#!/bin/bash
# ============================================================================
# Agent Skills Library — Setup & Activation Script
# ============================================================================
# Usage:
#   bash setup.sh install              # Clone all 6 skill repos
#   bash setup.sh update               # Pull latest for all repos
#   bash setup.sh activate-a <ws>      # Link copilot-instructions.md
#   bash setup.sh activate-b <ws>      # Link 58 skills to .github/skills/ ⭐
#   bash setup.sh activate-c           # Copy to ~/.claude/skills/ (global)
#   bash setup.sh status               # Show what's installed
# ============================================================================

set -euo pipefail

LIB_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="$LIB_DIR/skills"
TOOLS_DIR="$LIB_DIR/tools"

# ── Color helpers ──────────────────────────────────────────────────────────
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color
info()  { echo -e "${BLUE}[INFO]${NC}  $*"; }
ok()    { echo -e "${GREEN}[OK]${NC}    $*"; }
warn()  { echo -e "${YELLOW}[WARN]${NC}  $*"; }

# ── Repo definitions ───────────────────────────────────────────────────────
declare -A REPOS=(
    ["skills/anthropic-skills"]="https://github.com/anthropics/skills.git"
    ["skills/addyosmani-agent-skills"]="https://github.com/addyosmani/agent-skills.git"
    ["skills/context-engineering"]="https://github.com/muratcankoylan/Agent-Skills-for-Context-Engineering.git"
    ["skills/awesome-agent-skills"]="https://github.com/VoltAgent/awesome-agent-skills.git"
    ["skills/vercel-skills-cli"]="https://github.com/vercel-labs/skills.git"
    ["tools/SkillSpector"]="https://github.com/NVIDIA/SkillSpector.git"
)

# Skill source → prefix mapping
declare -A PREFIX_MAP=(
    ["anthropic-skills"]="an--"
    ["addyosmani-agent-skills"]="addy--"
    ["context-engineering"]="ctx--"
)

# ============================================================================
# install — Clone all skill repos
# ============================================================================
cmd_install() {
    mkdir -p "$SKILLS_DIR" "$TOOLS_DIR"
    for path in "${!REPOS[@]}"; do
        local url="${REPOS[$path]}"
        local full_path="$LIB_DIR/$path"
        if [ -d "$full_path/.git" ]; then
            ok "Already exists: $path"
        else
            rm -rf "$full_path"
            info "Cloning: $path"
            GIT_HTTP_LOW_SPEED_LIMIT=0 GIT_HTTP_LOW_SPEED_TIME=600 \
                git clone --depth 1 "$url" "$full_path"
            ok "Done: $path"
        fi
    done
    ok "All repos installed. Total: ${#REPOS[@]}"
}

# ============================================================================
# update — Pull latest for all repos
# ============================================================================
cmd_update() {
    for path in "${!REPOS[@]}"; do
        local full_path="$LIB_DIR/$path"
        if [ -d "$full_path/.git" ]; then
            info "Updating: $path"
            (cd "$full_path" && git pull --ff-only 2>&1 || warn "Pull failed: $path")
        else
            warn "Not found: $path — run 'install' first"
        fi
    done
    ok "Update complete."
}

# ============================================================================
# activate-a — Link copilot-instructions.md to workspace
# ============================================================================
cmd_activate_a() {
    local ws="${1:-}"
    [ -z "$ws" ] && { echo "Usage: setup.sh activate-a <workspace-path>"; exit 1; }
    [ ! -d "$ws" ] && { echo "ERROR: workspace not found: $ws"; exit 1; }

    mkdir -p "$ws/.github"
    ln -sfn "$LIB_DIR/copilot-instructions.md" "$ws/.github/copilot-instructions.md"
    ok "Linked: $ws/.github/copilot-instructions.md → $LIB_DIR/copilot-instructions.md"
    echo "   Restart VS Code to apply."
}

# ============================================================================
# activate-b — Link 58 skills to .github/skills/ ⭐ Recommended
# ============================================================================
cmd_activate_b() {
    local ws="${1:-}"
    [ -z "$ws" ] && { echo "Usage: setup.sh activate-b <workspace-path>"; exit 1; }
    [ ! -d "$ws" ] && { echo "ERROR: workspace not found: $ws"; exit 1; }

    local gh_skills="$ws/.github/skills"
    mkdir -p "$gh_skills"

    # Also link copilot-instructions
    mkdir -p "$ws/.github"
    ln -sfn "$LIB_DIR/copilot-instructions.md" "$ws/.github/copilot-instructions.md"

    local count=0
    for src_dir in "${!PREFIX_MAP[@]}"; do
        local prefix="${PREFIX_MAP[$src_dir]}"
        local src_path="$SKILLS_DIR/$src_dir/skills"
        if [ ! -d "$src_path" ]; then
            warn "Source not found: $src_path — run 'install' first"
            continue
        fi
        for skill_dir in "$src_path"/*/; do
            [ ! -d "$skill_dir" ] && continue
            local name; name=$(basename "$skill_dir")
            [ ! -f "$skill_dir/SKILL.md" ] && continue
            ln -sfn "$skill_dir" "$gh_skills/$prefix$name"
            ((count++))
        done
    done

    ok "Activated $count skills → $gh_skills"
    ok "Also linked copilot-instructions.md"
    echo "   Restart VS Code to apply."
}

# ============================================================================
# activate-c — Copy skills to ~/.claude/skills/ (global, all workspaces)
# ============================================================================
cmd_activate_c() {
    local claude_dir="${HOME}/.claude/skills"
    mkdir -p "$claude_dir"

    local count=0
    for src_dir in "${!PREFIX_MAP[@]}"; do
        local prefix="${PREFIX_MAP[$src_dir]}"
        local src_path="$SKILLS_DIR/$src_dir/skills"
        if [ ! -d "$src_path" ]; then
            warn "Source not found: $src_path — run 'install' first"
            continue
        fi
        for skill_dir in "$src_path"/*/; do
            [ ! -d "$skill_dir" ] && continue
            local name; name=$(basename "$skill_dir")
            [ ! -f "$skill_dir/SKILL.md" ] && continue
            cp -r "$skill_dir" "$claude_dir/$prefix$name"
            ((count++))
        done
    done

    ok "Copied $count skills → $claude_dir"
    echo "   Restart VS Code to apply."
}

# ============================================================================
# status — Show what's installed and activated
# ============================================================================
cmd_status() {
    echo "=== Library: $LIB_DIR ==="
    echo ""
    echo "--- Repos ---"
    for path in "${!REPOS[@]}"; do
        local full_path="$LIB_DIR/$path"
        if [ -d "$full_path/.git" ]; then
            echo "  ✅ $path"
        else
            echo "  ❌ $path (not installed)"
        fi
    done
    echo ""
    echo "--- Skills count ---"
    local total=0
    for src_dir in "${!PREFIX_MAP[@]}"; do
        local src_path="$SKILLS_DIR/$src_dir/skills"
        if [ -d "$src_path" ]; then
            local n; n=$(ls -d "$src_path"/*/ 2>/dev/null | wc -l)
            echo "  ${src_dir}: $n skills"
            ((total+=n))
        fi
    done
    echo "  Total: $total skills"
}

# ============================================================================
# Main
# ============================================================================
case "${1:-}" in
    install)    cmd_install ;;
    update)     cmd_update ;;
    activate-a) cmd_activate_a "${2:-}" ;;
    activate-b) cmd_activate_b "${2:-}" ;;
    activate-c) cmd_activate_c ;;
    status)     cmd_status ;;
    *)
        echo "Usage: bash setup.sh <command> [args]"
        echo ""
        echo "Commands:"
        echo "  install               Clone all 6 skill repos"
        echo "  update                Pull latest for all repos"
        echo "  activate-a <ws>       方案A: Link copilot-instructions.md"
        echo "  activate-b <ws>       方案B: Link 58 skills to .github/skills/ ⭐"
        echo "  activate-c            方案C: Copy to ~/.claude/skills/ (global)"
        echo "  status                Show install & activation status"
        echo ""
        echo "Example:"
        echo "  bash setup.sh install"
        echo "  bash setup.sh activate-b /path/to/your/project"
        ;;
esac
