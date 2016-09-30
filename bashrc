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

# Source aliases from separate file if present.
[ -f ~/.bash_aliases ] && source ~/.bash_aliases
[ -f ~/.bashrc_local ] && source ~/.bashrc_local

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

# Use Vim as the default editor.
export VISUAL=vim
export EDITOR=vim

# Enable vi-keybindings.
set -o vi

# Add user-local bin to path.
if [ -d "${HOME}/Bin" ] ; then
    export PATH=$PATH:${HOME}/Bin
fi


# All prompt customization - colors, format, etc; is handled by liquidprompt.
# Only load Liquid Prompt in interactive shells, not from a script or from scp.
[[ $- = *i* ]] && [[ -f "${HOME}/dotfiles/liquidprompt" ]] && source "${HOME}/dotfiles/liquidprompt"

# Highlighting inside manpages and elsewhere.
# Nicked from: https://github.com/paulirish/dotfiles/blob/master/.bash_profile
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;226m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
