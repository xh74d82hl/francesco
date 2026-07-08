#!/usr/bin/env bash
# Francesco family installer.
# Installs main skill + all sub-skills for the detected agent.
#
# Local:  bash install.sh [--agent <name>] [--yes]
# Remote: bash <(curl -fsSL URL) <OWNER>/francesco [--yes]

set -euo pipefail

SKILLS=("francesco" "francesco-revisione" "francesco-bilancio" "francesco-estratto")
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
  bash install.sh <OWNER>/francesco
  bash install.sh <OWNER>/francesco --yes
  bash install.sh <OWNER>/francesco --agent opencode
  bash install.sh --list
  bash install.sh --dev-copy --target ~/.agents/skills

Installs all francesco-* skills for the detected agent.
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
    info "rerun with --agent opencode, --agent claude-code, or --agent cursor" >&2
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

install_skill() {
  local skill_source="$1"
  local skill_name="$2"
  local agent="$3"
  local yes="$4"
  local yes_args=()
  if [ "$yes" -eq 1 ]; then yes_args+=("--yes"); fi

  info "  $skill_name..."
  npx skills add "$skill_source" --global --skill "$skill_name" --agent "$agent" "${yes_args[@]}"
}

install_all() {
  local source="$1"
  local agent="$2"
  local yes="$3"

  if [ -f "$SCRIPT_DIR/SKILL.md" ]; then
    # Local install: point directly to each skill directory
    info "installing from local path: $SCRIPT_DIR"
    install_skill "$SCRIPT_DIR" "francesco" "$agent" "$yes"
    for skill_dir in "$SCRIPT_DIR/skills/"*/; do
      local name
      name="$(basename "$skill_dir")"
      install_skill "$skill_dir" "$name" "$agent" "$yes"
    done
  else
    # Remote install: use source repo URL
    info "installing from remote: $source"
    for skill in "${SKILLS[@]}"; do
      install_skill "$source" "$skill" "$agent" "$yes"
    done
  fi
}

dev_copy() {
  local target="$1"
  local dest="$target/francesco"
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
  # Also dev-copy each sub-skill
  for skill_dir in "$SCRIPT_DIR/skills/"*/; do
    local name
    name="$(basename "$skill_dir")"
    local sdest="$target/$name"
    mkdir -p "$sdest"
    rsync -a --exclude='.git' "$skill_dir/" "$sdest/"
    ok "dev-copied $name to $sdest"
  done
  ok "dev-copied francesco to $dest"
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

  install_all "$source" "$chosen" "$yes"
  ok "installed ${SKILLS[*]} for $chosen"
}

main "$@"
