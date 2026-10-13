# Francesco family installer for Windows. Copies the skills into your agent's skills folder.
#
# Remote: irm https://raw.githubusercontent.com/xh74d82hl/francesco/main/install.ps1 | iex
# Local:  .\install.ps1 [-Agent <name>] [-Dir <path>] [-Yes]

param(
  [string]$Agent = "",
  [string]$Dir = "",
  [switch]$Yes,
  [switch]$List
)

$ErrorActionPreference = "Stop"
$Repo = if ($env:FRANCESCO_REPO) { $env:FRANCESCO_REPO } else { "xh74d82hl/francesco" }
$Branch = if ($env:FRANCESCO_BRANCH) { $env:FRANCESCO_BRANCH } else { "main" }
# Empty when run through `irm | iex`.
$ScriptDir = if ($PSScriptRoot) { $PSScriptRoot } else { "" }

function Info($Message) { Write-Host "info $Message" -ForegroundColor Cyan }
function Ok($Message) { Write-Host "ok $Message" -ForegroundColor Green }
function Fail($Message) { Write-Host "error $Message" -ForegroundColor Red; exit 1 }

function Get-AgentDir($Name) {
  switch ($Name) {
    { $_ -in "claude-code", "claude" } { return (Join-Path $HOME ".claude/skills") }
    "opencode" { return (Join-Path $HOME ".config/opencode/skills") }
    "agents" { return (Join-Path $HOME ".agents/skills") }
    default { Fail "unknown agent: $Name (use claude-code, opencode, agents, or -Dir <path>)" }
  }
}

function Get-DetectedAgents {
  $Detected = @()
  if (Test-Path (Join-Path $HOME ".claude")) { $Detected += "claude-code" }
  if (Test-Path (Join-Path $HOME ".config/opencode")) { $Detected += "opencode" }
  # No known agent: fall back to the shared ~/.agents/skills folder.
  if ($Detected.Count -eq 0) { $Detected += "agents" }
  return $Detected
}

function Choose-Agent([bool]$SkipPrompt) {
  $Detected = @(Get-DetectedAgents)
  if ($Detected.Count -eq 1) { return $Detected[0] }
  if ($SkipPrompt) {
    Fail "multiple agents detected: $($Detected -join ', '). Rerun with -Agent <name>; refusing to install everywhere."
  }
  Info "detected agents:"
  for ($i = 0; $i -lt $Detected.Count; $i++) {
    Write-Host "  $($i + 1)) $($Detected[$i])"
  }
  $Choice = Read-Host "Choose target agent"
  if (-not ($Choice -as [int]) -or [int]$Choice -lt 1 -or [int]$Choice -gt $Detected.Count) {
    Fail "invalid choice"
  }
  return $Detected[[int]$Choice - 1]
}

if ($List) {
  Get-DetectedAgents | ForEach-Object { Write-Host $_ }
  exit 0
}

$Target = $Dir
if (-not $Target) {
  if (-not $Agent) { $Agent = Choose-Agent $Yes.IsPresent }
  $Target = Get-AgentDir $Agent
}

$TempDir = ""
try {
  # Source: this repo, or a fresh download.
  if ($ScriptDir -and (Test-Path (Join-Path $ScriptDir "skills/francesco/SKILL.md"))) {
    $Source = $ScriptDir
  } else {
    $TempDir = Join-Path ([System.IO.Path]::GetTempPath()) ("francesco-" + [System.Guid]::NewGuid().ToString("N"))
    New-Item -ItemType Directory -Force -Path $TempDir | Out-Null
    $Zip = Join-Path $TempDir "francesco.zip"
    Info "downloading $Repo ($Branch)..."
    Invoke-WebRequest -Uri "https://github.com/$Repo/archive/refs/heads/$Branch.zip" -OutFile $Zip -UseBasicParsing
    Expand-Archive -Path $Zip -DestinationPath $TempDir -Force
    $Source = (Get-ChildItem -Path $TempDir -Directory | Select-Object -First 1).FullName
  }

  New-Item -ItemType Directory -Force -Path $Target | Out-Null
  Get-ChildItem -Path (Join-Path $Source "skills") -Directory | ForEach-Object {
    $Dest = Join-Path $Target $_.Name
    New-Item -ItemType Directory -Force -Path $Dest | Out-Null
    # Replace our own reference files so removed ones do not linger.
    $OldRefs = Join-Path $Dest "references"
    if (Test-Path $OldRefs) { Remove-Item -Recurse -Force $OldRefs }
    Copy-Item -Path (Join-Path $_.FullName "*") -Destination $Dest -Recurse -Force
    Ok "installed $($_.Name)"
  }
  Ok "done: $Target"
  Info "restart your agent, then type /francesco"
} finally {
  if ($TempDir -and (Test-Path $TempDir)) { Remove-Item -Recurse -Force $TempDir }
}
