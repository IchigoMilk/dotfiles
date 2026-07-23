# ~/.bashrc — managed by dotfiles (~/dotfiles/bash/.bashrc)
# Do not edit directly; edit the source in ~/dotfiles instead.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# =============================================================================
# History
# =============================================================================
HISTCONTROL=ignoreboth   # ignore duplicates and lines starting with space
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s histappend      # append rather than overwrite history file

# =============================================================================
# Shell options
# =============================================================================
shopt -s checkwinsize    # update LINES/COLUMNS after each command
shopt -s globstar 2>/dev/null  # enable ** glob (bash 4+)
shopt -s cdspell 2>/dev/null   # auto-correct minor typos in cd

# =============================================================================
# Prompt
# =============================================================================
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt

# Set terminal title
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
esac

# =============================================================================
# lesspipe — friendlier less for non-text files
# =============================================================================
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# =============================================================================
# Completion
# =============================================================================
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# =============================================================================
# Dotfiles: shared exports and aliases
# =============================================================================
DOTFILES_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/.."
[ -f "$DOTFILES_DIR/shell/exports.sh" ] && . "$DOTFILES_DIR/shell/exports.sh"
[ -f "$DOTFILES_DIR/shell/aliases.sh" ] && . "$DOTFILES_DIR/shell/aliases.sh"
unset DOTFILES_DIR

# =============================================================================
# Access tokens (machine-specific, not tracked — see shell/tokens.sh.example)
# =============================================================================
[ -f "$HOME/.bashrc.tokens" ] && . "$HOME/.bashrc.tokens"

# =============================================================================
# Local overrides (machine-specific, not tracked)
# =============================================================================
[ -f "$HOME/.bashrc.local" ] && . "$HOME/.bashrc.local"

# >>> grok installer >>>
export PATH="$HOME/.grok/bin:$PATH"
[[ -r "$HOME/.grok/completions/bash/grok.bash" ]] && source "$HOME/.grok/completions/bash/grok.bash"
# <<< grok installer <<<
