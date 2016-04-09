# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Enable 256 color support
export TERM="xterm-256color"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="jonas"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
 COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# define where custom plugins live:
#ZSH_CUSTOM=~/.oh-my-zsh/custom/

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(vi-mode git history-substring-search)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/spock/Bin"
# export MANPATH="/usr/local/man:$MANPATH"
export ANDROID_HOME=/home/spock/Android/Sdk
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
export ANDROID_EMULATOR_FORCE_32BIT=true

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# set default editor to vim
export VISUAL="vim"
export EDITOR="vim"

## set vi mode
set -o vi

## By default, there is a 400 ms second delay between mode changes in VI-mode.
 # this sets it to 100 ms seconds.
export KEYTIMEOUT=1

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Aliases ______________________________________________________________________
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias open="xdg-open"
alias hgrep="history | grep"
alias apts="apt-cache search"
alias aptsh="apt-cache show"
alias move="mv -vni --"
alias copy="cp -vni --"
alias trash="gvfs-trash"
alias grepin='grep -iRnHa --'
alias qmv='qmv --editor=vim --format=destination-only --'
alias copypwd='pwd | head -c -1 | xclip -sel clip'

# Find files and directories, anywhere. Not case sensitive.
function fufind() {
    find / -iname "*$1*" 2>/dev/null
}


setopt INTERACTIVE_COMMENTS         # treat hash characters as comment delimiter


# Keybind for searching history 
# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
#bindkey '\e[A' history-beginning-search-backward
#bindkey '\e[B' history-beginning-search-forward
