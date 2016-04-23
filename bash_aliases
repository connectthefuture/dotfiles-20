# ~/.bash_aliases
#
# Alias definitions
# =================
# I keep my additions here, for easier access and modularity.
# This file is sourced by ~/.bashrc at shell spawn, effectively inserting it
# inline.  See /usr/share/doc/bash-doc/examples in the bash-doc package.


# ls
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -al'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# git
alias gst='git status'
alias ga='git add'
alias gc='git commit'
alias gco='git checkout'
alias gcm='git checkout master'
alias gd='git diff'
alias gdca='git diff --cached'

# apt
apts() { apt-cache search ${1} | egrep --color=always "^[^-]+"; }
#alias apts="apt-cache search"
alias aptsh='apt-cache show'
alias aptin='sudo apt-get install'

# Miscellaneous
alias open='xdg-open'
alias hgrep='history | grep'
alias ack=ack-grep
alias grepin='grep -iRnHa --'

# Find files and directories, anywhere. Not case sensitive.
function fufind() {
    find / -iname "*$1*" 2>/dev/null
}

# rsync
alias rsync-copy="rsync -avz --progress -h"
alias rsync-move="rsync -avz --progress -h --remove-source-files"
alias rsync-update="rsync -avzu --progress -h"
alias rsync-synchronize="rsync -avzu --delete --progress -h"


# safer variants of standard commands
alias move="mv -nvi --"
alias copy="cp -nv --"
