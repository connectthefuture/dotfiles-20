# ~/.bash_aliases
#
# Alias definitions
# =================
# I keep my additions here, for easier access and modularity.
# This file is sourced by ~/.bashrc at shell spawn, effectively inserting it
# inline.  See /usr/share/doc/bash-doc/examples in the bash-doc package.

# Wrapper 'trynotify' suppresses errors when notify-send is unavailable.
function trynotify() {
    if command -v "notify-send" >/dev/null 2>&1 ; then
        notify-send "$@"
    fi
}

# ls
alias la='ls -A'
alias l='ls -ahl'

# Related to shell builtins
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git
alias gst='git status'
alias ga='git add'
alias gap='git add --patch'
alias gc='git commit --verbose'
alias gca='git commit --verbose --amend'
alias gco='git checkout'
alias gcm='git checkout master'
alias gd='git diff'
alias gdca='git diff --cached'
# Copy last commit message to the clipboard.
alias gcopylog='git log -1 --pretty=format:%s%n%b | xclip -sel clip'

# Git clone wrapper keeps the trailing ".git" in the destination name.
function gcl() {
    [ -z "$1" ] && return
    dest="$(basename "${1}")"
    git clone "$1" "$dest" && trynotify -i git "Git clone finished" \
    "Source repo: \"${1}\"\nReceived (size, destination): $(du -hs "$dest")"
}

# apt
apts() { apt-cache search ^${1} | egrep --color=always "^[^-]+"; }
#alias apts="apt-cache search"
alias aptsh='apt-cache show'
alias aptin='sudo apt-get install'

# Miscellaneous ..
alias open='xdg-open'
alias hgrep='history | grep -i --'
alias trash="gvfs-trash"
alias grepin='grep --initial-tab -iRnHa --'
alias ack='ack-grep'
alias vilog='vim ~/Dropbox/log.md'
alias dfu='df -h -T -x devtmpfs -x tmpfs'

# Simple preview of markdown files.
function mdless () {
    pandoc "$1" | lynx -stdin -dump | less
}

# Copy current working directory to system clipboard.
alias copypwd='pwd | head -c -1 | xclip -sel clip'

# Find files and directories, anywhere. Not case sensitive.
function fufind() {
    find / -iname "*${1}*" 2>/dev/null
}

# rsync
alias rsync-copy="rsync -avz --progress -h"
alias rsync-move="rsync -avz --progress -h --remove-source-files"
alias rsync-update="rsync -avzu --progress -h"
alias rsync-synchronize="rsync -avzu --delete --progress -h"

# renameutils
alias qmv="qmv --editor=vim --format=destination-only"

# "Safer" variants of standard commands
alias move="mv -nvi --"
alias copy="cp -nv --"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" \
                                          "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
