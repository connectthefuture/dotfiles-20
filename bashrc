# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything.
case $- in
    *i*) ;;
      *) return;;
esac

# Set variables, simplified hostname and operating system.
host=$(echo $(hostname) | sed "s/$(echo "$(hostname -s)\.")//g")
os=$(uname -s)

# Ignore duplicate lines and lines with leading space.
HISTCONTROL=ignoreboth

# Append, do not overwrite history.
shopt -s histappend

# For setting history length see HISTSIZE and HISTFILESIZE in bash(1).
HISTSIZE=50000
HISTFILESIZE=100000

# Timestamp history in ISO 8601 format.
HISTTIMEFORMAT='%F %T '

# Check the window size after each command and, if necessary, update the values
# of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# Enable colored prompt.
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Enable color support of ls and also add handy aliases.
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Source aliases from separate file if present.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
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

# Use Vim as the default editor.
export VISUAL=vim
export EDITOR=vim

# Enable vi-keybindings.
set -o vi

# Microchip XC8 PIC compiler
#export PATH=$PATH:"/opt/microchip/xc8/v1.33/bin"
# pk2cmd PICkit2 command line tool
#export PATH=$PATH:/usr/share/pk2

# Add user-local bin to path.
if [ -d "${HOME}/Bin" ] ; then
    export PATH=$PATH:${HOME}/Bin
fi

# Android SDK
# export ANDROID_HOME="${HOME}/Android/Sdk"
# export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
# export ANDROID_EMULATOR_FORCE_32BIT=true

# Only load Liquid Prompt in interactive shells, not from a script or from scp
[[ $- = *i* ]] && [[ -f "${HOME}/dotfiles/liquidprompt" ]] && source "${HOME}/dotfiles/liquidprompt"

# Highlighting inside manpages and elsewhere.
# Nicked from: https://github.com/paulirish/dotfiles/blob/master/.bash_profile
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
