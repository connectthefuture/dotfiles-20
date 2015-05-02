# ~/.bash_aliases
# 
# Alias definitions
# =================
# I keep my additions here, for easier access and modularity. This file is
# sourced by ~/.bashrc at shell spawn, effectively inserting it inline. 

#     You may want to put all your additions into a separate file like
#     ~/.bash_aliases, instead of adding them here directly.
#     See /usr/share/doc/bash-doc/examples in the bash-doc package.
#
# 


# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -al'
alias open='xdg-open'
alias t='~/bin/todo/todo.sh'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ..2='cd../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'



# git
alias gst='git status'
alias ga='git add'
alias gc='git commit'
alias gco='git checkout'
alias gcm='git checkout master'


# apt
alias apts='apt-cache search'
alias aptsh='apt-cache show'


# miscellaneous
alias hgrep='history | grep'
