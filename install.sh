#!/usr/bin/env bash
# Francesco installer.
# Public path: detect agent, then call `npx skills add` with --agent.
# Dev path: --dev-copy copies local repo files without deleting user data.

set -euo pipefail

SKILL_NAME="francesco"
DEFAULT_SOURCE="${FRANCESCO_REPO:-}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd || pwd)"

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
info() { printf "%b\n" "${CYAN}info${NC} $1"; }
ok() { printf "%b\n" "${GREEN}ok${NC} $1"; }
warn() { printf "%b\n" "${YELLOW}warn${NC} $1"; }
err() { printf "%b\n" "${RED}error${NC} $1"; }

usage() {
  cat <<'EOF'
Usage:
  bash install.sh <OWNER>/francesco-skill
  bash install.sh <OWNER>/francesco-skill --yes
  bash install.sh <OWNER>/francesco-skill --agent opencode
  bash install.sh --list
  bash install.sh --dev-copy --target ~/.agents/skills

Public installer:
  Detects installed harnesses and runs:
  npx skills add <source> --global --skill francesco --agent <agent>

Dev copy:
  Copies local files for testing. It never deletes normative/ or other user data.
EOF
}

detect_agents() {
  DETECTED=()
  if command -v opencode >/dev/null 2>&1; then DETECTED+=("opencode"); fi
  if command -v claude >/dev/null 2>&1 || command -v claude-code >/dev/null 2>&1; then DETECTED+=("claude-code"); fi
  if command -v cursor >/dev/null 2>&1; then DETECTED+=("cursor"); fi
  if command -v windsurf >/dev/null 2>&1; then DETECTED+=("windsurf"); fi
  if command -v github-copilot-cli >/dev/null 2>&1; then DETECTED+=("github-copilot"); fi
}

choose_agent() {
  local requested="$1"
  local yes="$2"

  if [ -n "$requested" ]; then
    printf "%s" "$requested"
    return 0
  fi

  detect_agents
  if [ "${#DETECTED[@]}" -eq 0 ]; then
    err "no supported harness detected" >&2
    info "rerun with --agent opencode, --agent claude-code, --agent cursor, or install manually with npx skills add" >&2
    exit 1
  fi

  if [ "${#DETECTED[@]}" -eq 1 ]; then
    printf "%s" "${DETECTED[0]}"
    return 0
  fi

  if [ "$yes" -eq 1 ]; then
    err "multiple harnesses detected: ${DETECTED[*]}" >&2
    info "rerun with --agent <name>; refusing to install everywhere" >&2
    exit 1
  fi

  info "detected harnesses:" >&2
  local i=1
  for agent in "${DETECTED[@]}"; do
    printf "  %s) %s\n" "$i" "$agent" >&2
    i=$((i + 1))
  done
  printf "Choose target agent: " >&2
  read -r choice
  if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 1 ] || [ "$choice" -gt "${#DETECTED[@]}" ]; then
    err "invalid choice" >&2
    exit 1
  fi
  printf "%s" "${DETECTED[$((choice - 1))]}"
}

install_with_skills() {
  local source="$1"
  local agent="$2"
  local yes="$3"
  local yes_args=()
  if [ "$yes" -eq 1 ]; then yes_args+=("--yes"); fi

  info "install source: $source"
  info "target agent: $agent"
  npx skills add "$source" --global --skill "$SKILL_NAME" --agent "$agent" "${yes_args[@]}"
}

dev_copy() {
  local target="$1"
  local dest="$target/$SKILL_NAME"
  if [ ! -f "$SCRIPT_DIR/SKILL.md" ]; then
    err "--dev-copy requires running from local repo"
    exit 1
  fi
  mkdir -p "$dest"
  rsync -a \
    --exclude='.git' \
    --exclude='normative/' \
    --exclude='scripts/' \
    "$SCRIPT_DIR/" "$dest/"
  ok "dev-copied to $dest"
  info "preserved existing normative/ and scripts/"
}

main() {
  local source="$DEFAULT_SOURCE"
  local agent=""
  local yes=0
  local list=0
  local dev=0
  local target="$HOME/.agents/skills"

  while [ "$#" -gt 0 ]; do
    case "$1" in
      --help|-h) usage; exit 0 ;;
      --yes|-y) yes=1; shift ;;
      --list) list=1; shift ;;
      --agent) agent="${2:-}"; shift 2 ;;
      --agent=*) agent="${1#*=}"; shift ;;
      --dev-copy) dev=1; shift ;;
      --target) target="${2:-}"; shift 2 ;;
      --target=*) target="${1#*=}"; shift ;;
      -*) err "unknown option: $1"; usage; exit 1 ;;
      *) source="$1"; shift ;;
    esac
  done

  detect_agents
  if [ "$list" -eq 1 ]; then
    if [ "${#DETECTED[@]}" -eq 0 ]; then
      warn "no supported harness detected"
    else
      printf "%s\n" "${DETECTED[@]}"
    fi
    exit 0
  fi

  if [ "$dev" -eq 1 ]; then
    dev_copy "$target"
    exit 0
  fi

  if [ -z "$source" ]; then
    if [ -f "$SCRIPT_DIR/SKILL.md" ]; then
      source="$SCRIPT_DIR"
    else
      err "missing source repo"
      usage
      exit 1
    fi
  fi

  local chosen
  chosen="$(choose_agent "$agent" "$yes")"
  install_with_skills "$source" "$chosen" "$yes"
  ok "installed $SKILL_NAME for $chosen"
}

main "$@"
