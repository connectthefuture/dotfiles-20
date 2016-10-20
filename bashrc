# ~/.bashrc -- The individual per-interactive-shell startup file.


# If not running interactively, don't do anything.
case $- in
    *i*) ;;
      *) return;;
esac

# Ignore duplicate lines and lines with leading space.
HISTCONTROL=ignoreboth

# Do not truncate the history file, I.E. unlimited size.
HISTSIZE=-1
HISTFILESIZE=-1

# History entry timestamps in ISO-8601 format ('YYYY-MM-DD HH:MM:SS').
HISTTIMEFORMAT='%F %T '

# Append, do not overwrite history.
shopt -s histappend

# Dynamically redraw window contents when resizing.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Enable color support of ls and also add handy aliases.
if [ -x /usr/bin/dircolors ]; then
    [ -r ~/.dircolors ] && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# Enable completion for Pandoc.
if command -v "pandoc" >/dev/null 2>&1; then
    eval "$(pandoc --bash-completion)"
fi

# Enable vi-keybindings.
set -o vi


# Source aliases from separate file if present.
[ -f "${HOME}/.bash_aliases" ] && source "${HOME}/.bash_aliases"
[ -f "${HOME}/.bashrc_local" ] && source "${HOME}/.bashrc_local"
[ -f "${HOME}/.env_vars"     ] && source "${HOME}/.env_vars"

# All prompt customization - colors, format, etc; is handled by liquidprompt.
# Only load Liquid Prompt in interactive shells, not from a script or from scp.
[[ $- = *i* ]] && [[ -f "${HOME}/dotfiles/liquidprompt" ]] && source "${HOME}/dotfiles/liquidprompt"
