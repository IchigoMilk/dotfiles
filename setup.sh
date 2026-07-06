#!/usr/bin/env bash
# =============================================================================
# dotfiles/setup.sh — Install dotfiles by symlinking rc files
#
# Usage: bash ~/dotfiles/setup.sh
#        bash ~/dotfiles/setup.sh --dry-run
# =============================================================================
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DRY_RUN=false
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=true

# --- helpers -----------------------------------------------------------------

info()  { echo "  [info]  $*"; }
ok()    { echo "  [ ok ]  $*"; }
warn()  { echo "  [warn]  $*"; }

# Back up an existing file/symlink, then create a symlink src -> dst.
link() {
    local src="$1"
    local dst="$2"

    if $DRY_RUN; then
        info "dry-run: would link $dst -> $src"
        return
    fi

    # Remove stale symlink pointing to the same source
    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
        ok "Already linked: $dst"
        return
    fi

    # Back up any existing file or different symlink
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        local backup="${dst}.bak.$(date +%Y%m%d%H%M%S)"
        warn "Backing up: $dst -> $backup"
        mv "$dst" "$backup"
    fi

    ln -s "$src" "$dst"
    ok "Linked: $dst -> $src"
}

# Add a git global include.path entry (idempotent)
git_include() {
    local cfg="$1"
    if git config --global --get-all include.path | grep -qF "$cfg"; then
        ok "Git include already set: $cfg"
    else
        if $DRY_RUN; then
            info "dry-run: would add git include.path = $cfg"
        else
            git config --global --add include.path "$cfg"
            ok "Git include added: $cfg"
        fi
    fi
}

# --- main --------------------------------------------------------------------

echo ""
echo "Dotfiles setup — $DOTFILES_DIR"
$DRY_RUN && echo "(dry-run mode — no changes will be made)"
echo ""

# Shell RC files
link "$DOTFILES_DIR/bash/.bashrc" "$HOME/.bashrc"
link "$DOTFILES_DIR/zsh/.zshrc"   "$HOME/.zshrc"

# Git aliases via include
git_include "$DOTFILES_DIR/git/config"

echo ""
echo "Done! Restart your shell, or:"
echo "  source ~/.bashrc    # bash"
echo "  source ~/.zshrc     # zsh"
