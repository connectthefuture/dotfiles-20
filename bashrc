# ~/.bashrc -- The individual per-interactive-shell startup file.


# If not running interactively, don't do anything.
case $- in
    *i*) ;;
      *) return;;
esac

# Ignore duplicate lines and lines with leading space.
HISTCONTROL=ignoreboth

# Do not truncate the history file, I.E. unlimited size.
HISTSIZE=
HISTFILESIZE=
HISTFILE="${HOME}/.bash_history"

# History entry timestamps in ISO-8601 format ('YYYY-MM-DD HH:MM:SS').
HISTTIMEFORMAT='%F %T '

# Continuously write history to disk. Synchronizes history between shells.
# Doesn't seem to work very well with iterm2 in MacOS, with Bash version:
# "GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin16)"
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    PROMPT_COMMAND='history -a ; history -n'
fi

# Append, do not overwrite history.
shopt -s histappend

# Save commands with embedded newlines instead of semicolons.
shopt -s lithist

# Dynamically redraw window contents when resizing.
shopt -s checkwinsize

# Do not execute history substitutions immediately.  Instead reload the
# expanded line into the readline editing buffer for further modification.
shopt -s histverify

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


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
[ -f "${HOME}/.bash_aliases" ] && . "${HOME}/.bash_aliases"
[ -f "${HOME}/.bashrc_local" ] && . "${HOME}/.bashrc_local"
[ -f "${HOME}/.env_vars"     ] && . "${HOME}/.env_vars"

# All prompt customization - colors, format, etc; is handled by liquidprompt.
# Only load Liquid Prompt in interactive shells, not from a script or from scp.
[[ $- = *i* ]] && [ -f "${HOME}/dotfiles/liquidprompt" ] && . "${HOME}/dotfiles/liquidprompt"

# Load "zfz -- Command-line Fuzzy Finder" config if available.
[ -f "$HOME/.fzf.bash" ] && . "$HOME/.fzf.bash"

# Temporary solution for platform-specific stuff ..
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    # Make the "Caps Lock" behave as another "Ctrl" key.
    setxkbmap -option ctrl:nocaps

    # Enable ls color support.
    if [ -x /usr/bin/dircolors ]; then
        [ -r ~/.dircolors ] && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    fi
fi
