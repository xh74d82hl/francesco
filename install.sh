#!/usr/bin/env bash
# Francesco family installer. Copies the skills into your agent's skills folder.
# Needs only bash, curl and tar.
#
# Remote: curl -fsSL https://raw.githubusercontent.com/xh74d82hl/francesco/main/install.sh | bash
# Local:  bash install.sh [--agent <name>] [--dir <path>] [--yes]

set -euo pipefail

REPO="${FRANCESCO_REPO:-xh74d82hl/francesco}"
BRANCH="${FRANCESCO_BRANCH:-main}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-.}")" 2>/dev/null && pwd || pwd)"

RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'; NC='\033[0m'
info() { printf "%b\n" "${CYAN}info${NC} $1"; }
ok() { printf "%b\n" "${GREEN}ok${NC} $1"; }
err() { printf "%b\n" "${RED}error${NC} $1" >&2; }

usage() {
  cat <<'EOF'
Usage:
  bash install.sh                      auto-detect the agent
  bash install.sh --agent claude-code  ~/.claude/skills
  bash install.sh --agent opencode     ~/.config/opencode/skills
  bash install.sh --agent agents       ~/.agents/skills
  bash install.sh --dir <path>         any other skills folder
  bash install.sh --list               show detected agents
  bash install.sh --yes                never prompt

Installs francesco, francesco-revisione, francesco-bilancio, francesco-estratto.
EOF
}

agent_dir() {
  case "$1" in
    claude-code|claude) printf "%s" "$HOME/.claude/skills" ;;
    opencode) printf "%s" "$HOME/.config/opencode/skills" ;;
    agents) printf "%s" "$HOME/.agents/skills" ;;
    *) err "unknown agent: $1 (use claude-code, opencode, agents, or --dir <path>)"; exit 1 ;;
  esac
}

detect_agents() {
  DETECTED=()
  if [ -d "$HOME/.claude" ]; then DETECTED+=("claude-code"); fi
  if [ -d "$HOME/.config/opencode" ]; then DETECTED+=("opencode"); fi
  # No known agent: fall back to the shared ~/.agents/skills folder.
  if [ "${#DETECTED[@]}" -eq 0 ]; then DETECTED+=("agents"); fi
}

choose_agent() {
  local yes="$1"
  detect_agents
  if [ "${#DETECTED[@]}" -eq 1 ]; then
    printf "%s" "${DETECTED[0]}"
    return 0
  fi
  if [ "$yes" -eq 1 ] || [ ! -r /dev/tty ]; then
    err "multiple agents detected: ${DETECTED[*]}"
    err "rerun with --agent <name>; refusing to install everywhere"
    exit 1
  fi
  info "detected agents:" >&2
  local i=1
  for agent in "${DETECTED[@]}"; do
    printf "  %s) %s\n" "$i" "$agent" >&2
    i=$((i + 1))
  done
  printf "Choose target agent: " >&2
  # Read from the terminal: stdin is the script itself under `curl | bash`.
  read -r choice </dev/tty
  if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 1 ] || [ "$choice" -gt "${#DETECTED[@]}" ]; then
    err "invalid choice"
    exit 1
  fi
  printf "%s" "${DETECTED[$((choice - 1))]}"
}

# Prints the directory that holds the skills/ folder: this repo, or a fresh download.
fetch_source() {
  if [ -f "$SCRIPT_DIR/skills/francesco/SKILL.md" ]; then
    printf "%s" "$SCRIPT_DIR"
    return 0
  fi
  TMPDIR_FRANCESCO="$(mktemp -d)"
  info "downloading $REPO ($BRANCH)..." >&2
  curl -fsSL "https://github.com/$REPO/archive/refs/heads/$BRANCH.tar.gz" \
    | tar -xz -C "$TMPDIR_FRANCESCO" --strip-components=1
  printf "%s" "$TMPDIR_FRANCESCO"
}

install_skills() {
  local source="$1"
  local target="$2"
  mkdir -p "$target"
  for skill_dir in "$source/skills/"*/; do
    local name
    name="$(basename "$skill_dir")"
    mkdir -p "$target/$name"
    # Replace our own reference files so removed ones do not linger.
    rm -rf "$target/$name/references"
    cp -R "$skill_dir." "$target/$name/"
    ok "installed $name"
  done
}

main() {
  local agent=""
  local dir=""
  local yes=0
  local list=0

  while [ "$#" -gt 0 ]; do
    case "$1" in
      --help|-h) usage; exit 0 ;;
      --yes|-y) yes=1; shift ;;
      --list) list=1; shift ;;
      --agent) agent="${2:-}"; shift 2 ;;
      --agent=*) agent="${1#*=}"; shift ;;
      --dir) dir="${2:-}"; shift 2 ;;
      --dir=*) dir="${1#*=}"; shift ;;
      *) err "unknown option: $1"; usage; exit 1 ;;
    esac
  done

  if [ "$list" -eq 1 ]; then
    detect_agents
    printf "%s\n" "${DETECTED[@]}"
    exit 0
  fi

  local target="$dir"
  if [ -z "$target" ]; then
    if [ -z "$agent" ]; then agent="$(choose_agent "$yes")"; fi
    target="$(agent_dir "$agent")"
  fi

  TMPDIR_FRANCESCO=""
  trap 'if [ -n "$TMPDIR_FRANCESCO" ]; then rm -rf "$TMPDIR_FRANCESCO"; fi' EXIT
  local source
  source="$(fetch_source)"

  install_skills "$source" "$target"
  ok "done: $target"
  info "restart your agent, then type /francesco"
}

main "$@"
