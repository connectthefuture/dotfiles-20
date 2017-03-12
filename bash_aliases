# ~/.bash_aliases -- Aliases, sourced by ~/.bashrc.


# Tests that a command or list of commands are available.
# Returns true if ALL commands are available. Else false.
function command_exists() {
    for arg in "$@" ; do
        if ! command -v "$arg" >/dev/null 2>&1 ; then
            return 1
        fi
    done
    return 0
}

# Wrapper 'trynotify' suppresses errors caused by the environment somehow being
# unsuitable for running 'notify-send'. Not installed, in a SSH-session, etc ..
function trynotify() {
    if ! command_exists "notify-send"; then
        return
    elif [ -z $DISPLAY ]; then
        # Must be set, determines where the notifications appear.
        return
    elif [ "$(logname)" != "$USER" ]; then
        # Currently logged in user must be the desktop user.
        return
    fi

    notify-send "$@"
}

# ls
if [ -x /usr/bin/dircolors ]; then
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias la='ls -A'
alias l='ls -Ahl'
# TODO: Temporary solution for platform-specific stuff ..
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    alias ll='ls -Ahl --time-style=long-iso'
fi

# Related to shell builtins
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git
if command_exists git ; then
    alias gst='git status'
    alias ga='git add'
    alias gaa='git add --all'
    alias gap='git add --patch'
    alias gc='git commit --verbose'
    alias gca='git commit --verbose --amend'
    alias gco='git checkout'
    alias gcm='git checkout master'
    alias gd='git diff'
    alias gdw='git diff --word-diff'
    alias gdca='git diff --cached'
    alias gdcaw='git diff --cached --word-diff'
fi

# Git clone wrapper keeps the trailing ".git" in the destination name.
function gcl() {
    [ -z "${1:-}" ] && return

    dest="$(basename "${1}")"
    if git clone "$1" "$dest" ; then
        local iconpath="/usr/share/icons/hicolor/scalable/apps/gitg-symbolic.svg"
        [ -r "$iconpath" ] || iconpath=''

        dest_size="$(du -hs "$dest")"

        trynotify -i "$iconpath" "Git clone finished" \
        "Source repo: \"${1}\"\nReceived (size, destination): ${dest_size}"
    fi
}

# apt
apts() { apt-cache search ^${1} | egrep --color=always "^[^-]+"; }
#alias apts="apt-cache search"
alias aptsh='apt-cache show'
alias aptin='sudo apt-get install'

# Miscellaneous aliases.
alias hgrep='history | grep -i --'

if command_exists xdg-open ; then
    alias open='xdg-open'
fi

if command_exists gvfs-trash ; then
    alias trash="gvfs-trash"
fi

alias vilog='vim ~/Dropbox/log/log.md'
alias grepin='grep --initial-tab --color=always --exclude-dir={.git,.idea,node_modules} -iRnHa --'
alias dfu='df -h -T -x devtmpfs -x tmpfs'

# Output ANSI "color" escape sequences in raw form. Suppress slow line numbers.
alias less='less --RAW-CONTROL-CHARS --line-numbers'

# Recursively grep the current working directory, including only files
# with a specified extension, specified with the first argument.
# The second argument is the pattern to match.
# The output is columnated by file name, line number and matched text.
function grepsrctype() {
    grep --color=always --exclude-dir={.git,.idea,node_modules} \
         --include="*.${1}" -RnHa -- "$2" . | column -t -s':'
}

# Aliases for grepping files with specific file extensions.
alias grepsrcjava="grepsrctype java "$*""
alias grepsrcpy="grepsrctype py "$*""
alias grepsrcmd="grepsrctype md "$*""

# Insert current date and time in my preferred format.
alias isodatetight='date "+%FT%H%M%S"'

# Simple preview of markdown files.
function mdless() {
    if command_exists pandoc lynx ; then
        pandoc "$1" | lynx -stdin -dump | less;
    fi
}

# Interfacing with the ("desktop") clipboard.
#
#   - copypwd    Copy current working directory to system clipboard.
#   - gcopylog   Copy the most recent commit message to the clipboard.

# TODO: Temporary solution for platform-specific stuff ..
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    if command_exists xclip ; then
        alias copypwd='pwd | head -c -1 | xclip -sel clip'
        alias gcopylog='git log -1 --pretty=format:%s%n%b | xclip -sel clip'
    fi
elif [[ "$OSTYPE" == "darwin16" ]]; then
    # MacOS head does not support leaving off the last byte as in 'head -c -1'.
    # So use 'tr' instead to strip _all_ new lines (\n).  This is meant to
    # prevent direct execution when pasting to a terminal. However ..
    # TODO: Look up whether this is necessary.
    alias copypwd='pwd | tr -d "\n" | pbcopy'
    alias gcopylog='git log -1 --pretty=format:%s%n%b | pbcopy'

    if [ -x '/Applications/VLC.app/Contents/MacOS/VLC' ]; then
        alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
    fi
fi

# Find files and directories in current directory. Case insensitive.
findhere() { find . -iname "*${1}*" 2>/dev/null; }

# rsync
# alias rsync-copy="rsync -avz --progress -h"
# alias rsync-move="rsync -avz --progress -h --remove-source-files"
# alias rsync-update="rsync -avzu --progress -h"
# alias rsync-synchronize="rsync -avzu --delete --progress -h"

# renameutils
if command_exists qmv ; then
    alias qmv="qmv --editor=vim --format=destination-only"
fi

# "Safer" variants of standard commands
alias move="mv -nvi --"
alias copy="cp -nv --"
alias delete="rm -vi --"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" \
                                          "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# Shortcuts for changing the shell working directory.
# Function 'cd_existing_dir' checks that the given argument is an existing
# directory before changing to it. Used by the below aliases.
cd_existing_dir() {
    [ -d "$1" ] && cd "$1"
}

# Aliases for commonly used directories.
alias cdv021='cd_existing_dir ~/LNU/1DV021_Grundprog/'
alias cdv022='cd_existing_dir ~/LNU/1DV022_KlientbasWebbprog/'
alias cdv321='cd_existing_dir ~/LNU/1ME321_Webbteknik/'
alias cdv506='cd_existing_dir ~/LNU/1DV506_Problemlosning/'
alias cdv507='cd_existing_dir ~/LNU/1DV507_Datastrukturer/'
alias cdv600='cd_existing_dir ~/LNU/1DV600_Programvaruteknik/'
