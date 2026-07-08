param(
  [Parameter(Position = 0)]
  [string]$Source = $env:FRANCESCO_REPO,

  [string]$Agent = "",
  [switch]$Yes,
  [switch]$List,
  [switch]$DevCopy,
  [string]$Target = "$HOME/.agents/skills"
)

$ErrorActionPreference = "Stop"
$SkillName = "francesco"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

function Info($Message) { Write-Host "info $Message" -ForegroundColor Cyan }
function Ok($Message) { Write-Host "ok $Message" -ForegroundColor Green }
function Warn($Message) { Write-Host "warn $Message" -ForegroundColor Yellow }
function Fail($Message) { Write-Host "error $Message" -ForegroundColor Red; exit 1 }

function Test-Command($Name) {
  return [bool](Get-Command $Name -ErrorAction SilentlyContinue)
}

function Get-DetectedAgents {
  $Detected = @()
  if (Test-Command "opencode") { $Detected += "opencode" }
  if ((Test-Command "claude") -or (Test-Command "claude-code")) { $Detected += "claude-code" }
  if (Test-Command "cursor") { $Detected += "cursor" }
  if (Test-Command "windsurf") { $Detected += "windsurf" }
  if (Test-Command "github-copilot-cli") { $Detected += "github-copilot" }
  return $Detected
}

function Choose-Agent($Requested, [bool]$SkipPrompt) {
  if ($Requested) { return $Requested }

  $Detected = @(Get-DetectedAgents)
  if ($Detected.Count -eq 0) {
    Fail "no supported harness detected. Rerun with -Agent opencode, -Agent claude-code, or -Agent cursor."
  }
  if ($Detected.Count -eq 1) { return $Detected[0] }
  if ($SkipPrompt) {
    Fail "multiple harnesses detected: $($Detected -join ', '). Rerun with -Agent <name>; refusing to install everywhere."
  }

  Info "detected harnesses:"
  for ($i = 0; $i -lt $Detected.Count; $i++) {
    Write-Host "  $($i + 1)) $($Detected[$i])"
  }
  $Choice = Read-Host "Choose target agent"
  if (-not ($Choice -as [int]) -or [int]$Choice -lt 1 -or [int]$Choice -gt $Detected.Count) {
    Fail "invalid choice"
  }
  return $Detected[[int]$Choice - 1]
}

function Install-WithSkills($InstallSource, $TargetAgent, [bool]$SkipPrompt) {
  Info "install source: $InstallSource"
  Info "target agent: $TargetAgent"
  $Args = @("skills", "add", $InstallSource, "--global", "--skill", $SkillName, "--agent", $TargetAgent)
  if ($SkipPrompt) { $Args += "--yes" }
  & npx @Args
  if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
}

function Copy-Dev($InstallTarget) {
  if (-not (Test-Path (Join-Path $ScriptDir "SKILL.md"))) {
    Fail "-DevCopy requires running from local repo"
  }
  $Dest = Join-Path $InstallTarget $SkillName
  New-Item -ItemType Directory -Force -Path $Dest | Out-Null
  Get-ChildItem -Path $ScriptDir -Force | Where-Object {
    $_.Name -notin @(".git", "normative", "scripts")
  } | ForEach-Object {
    Copy-Item -Path $_.FullName -Destination $Dest -Recurse -Force
  }
  Ok "dev-copied to $Dest"
  Info "preserved existing normative/ and scripts/"
}

if ($List) {
  $Detected = @(Get-DetectedAgents)
  if ($Detected.Count -eq 0) { Warn "no supported harness detected" } else { $Detected | ForEach-Object { Write-Host $_ } }
  exit 0
}

if ($DevCopy) {
  Copy-Dev $Target
  exit 0
}

if (-not $Source) {
  if (Test-Path (Join-Path $ScriptDir "SKILL.md")) {
    $Source = $ScriptDir
  } else {
    Fail "missing source repo"
  }
}

$Chosen = Choose-Agent $Agent $Yes.IsPresent
Install-WithSkills $Source $Chosen $Yes.IsPresent
Ok "installed $SkillName for $Chosen"
