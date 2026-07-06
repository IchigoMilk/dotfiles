# ~/.zshrc — managed by dotfiles (~/dotfiles/zsh/.zshrc)
# Do not edit directly; edit the source in ~/dotfiles instead.

# =============================================================================
# History
# =============================================================================
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# =============================================================================
# Shell options
# =============================================================================
setopt AUTO_CD           # type a directory name to cd into it
setopt CORRECT           # suggest corrections for mistyped commands
setopt NO_BEEP

# =============================================================================
# Completion
# =============================================================================
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# =============================================================================
# Prompt (simple; install starship/oh-my-zsh for fancier prompts)
# =============================================================================
autoload -Uz colors && colors
PROMPT="%{$fg_bold[green]%}%n@%m%{$reset_color%}:%{$fg_bold[blue]%}%~%{$reset_color%}%# "

# =============================================================================
# Key bindings
# =============================================================================
bindkey -e                         # emacs key bindings
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# =============================================================================
# Dotfiles: shared exports and aliases
# =============================================================================
DOTFILES_DIR="$(dirname "$(readlink -f "${(%):-%x}")")/.."
[ -f "$DOTFILES_DIR/shell/exports.sh" ] && . "$DOTFILES_DIR/shell/exports.sh"
[ -f "$DOTFILES_DIR/shell/aliases.sh" ] && . "$DOTFILES_DIR/shell/aliases.sh"
unset DOTFILES_DIR

# =============================================================================
# uv shell completion
# =============================================================================
if command -v uv >/dev/null 2>&1; then
    eval "$(uv generate-shell-completion zsh)"
fi

# =============================================================================
# Local overrides (machine-specific, not tracked)
# =============================================================================
[ -f "$HOME/.zshrc.local" ] && . "$HOME/.zshrc.local"
