#!/bin/bash
#   ______________________________________________________________________

#   DOTFILES SETUP SCRIPT
#                              written by Jonas Sjöberg for *personal* use
#                                                 Last updated: 2015-05-17
#   ______________________________________________________________________

#   Should only ever need to be executed after a clean reinstall of the home
#   directory.  Replaces the standard "/home/user/.configfile"-files with
#   symlinks to files kept under version control in this here repository.
#   Some error checks are performed but please note that I WILL NOT take any
#   responsability for anything you might do with this script. Be careful.
#

# USER CONFIGURABLE VARIABLES
# These are the dotfiles that will be installed.
CONFIGFILES="bashrc bash_aliases vimrc vim zshrc oh-my-zsh gitconfig zshenv"

# Be verbose, print debug information.
VERBOSE=true


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# FIXED VARIABLES
DOTFILES_ROOT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
TEMP_DIR=$(mktemp -d dotfiles.XXXXXX)
BACKUP_ARCHIVE="$HOME/dotfiles_$(date +%F_%H-%M-%S).tar.gz"
MOVE="mv -vni"

[[ $VERBOSE ]] && cat << EOF
────────────────────────────────────────────────────────────────────────────────
  Dotfiles setup script
  =====================

* started with root: $DOTFILES_ROOT

* will symlink from source: $HOME
         .. to destination: $DOTFILES_ROOT
  .. acting on these files: $CONFIGFILES

* archiving any existing to: $BACKUP_ARCHIVE
────────────────────────────────────────────────────────────────────────────────

EOF

cd "$HOME"

# Run through the list of configfiles. Check if the source file (THIS_SRC)
# exists and is an ordinary file. Then check if it is a symbolic link, which
# is deleted. If it isn't a symlink, it is moved to a temporary directory, which
# is created if need be.
# Next, check if the destination file ($THIS_DST) exists. If it does, go ahead
# and create a symlink from source to destination.
for file in $CONFIGFILES;
do
    THIS_SRC="$HOME/.$file"              # this file is a link .. 
    THIS_DST="$DOTFILES_ROOT/$file"      # .. to this file

    if [ -f "$THIS_SRC" ]; then
        if [ -L "$THIS_SRC" ]; then
            echo "** removing symlink .$file .."
            rm -v "$THIS_SRC"
        else
            if [ ! -d "$TEMP_DIR" ]; then
                mkdir -pvv "$TEMP_DIR"   # setup a folder for temporary storage
            fi

            echo "** moving ".$file" out of the way .."
            $MOVE "$THIS_SRC" "$TEMP_DIR"
        fi
    fi

    if [ -e "$THIS_DST" ];               # check that file is in repo directory
    then                                 # if not, print error and die
        echo "** creating symlink .."    # else create symlink from SRC to DST
        ln -vsi "$THIS_DST" "$THIS_SRC"
        echo ""
    else
        echo "* error! $THIS_DST doesn't exist!"
        exit
    fi
done

printf "\n* done ..\n"

# Create a backup archive if needed. First check if the temporary directory
# exists. If it does, we can assume it contains our old dotfiles.
# Create a zipped tar archive with a date and timestamp in the filename.
# Then go ahead aand remove the temporary directory and files.
if [ -d "$TEMP_DIR" ]; then
    printf "\n** archiving the old dotfiles ..\n"

    # this assumes more than a minute passes between runs .. file exists error?
    find "$TEMP_DIR" -maxdepth 1 -type f -name ".*" -exec tar vczf "$BACKUP_ARCHIVE" "{}" +

    printf "\n* done ..\n"
    echo "** removing temporary files .."
    rm -vrf "$TEMP_DIR"
    
    printf "\n* done ..\n"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if command -v thunar >/dev/null; then
    # symlink thunar custom actions config file
    THUNARCONF_SRC="$HOME/.config/Thunar/uca.xml"       # this file is a link ..
    THUNARCONF_DST="$DOTFILES_ROOT/thunar-custom.xml"   # .. to this file
    THUNARCONF_BAK=""$THUNARCONF_SRC"_$(date +%F_%H-%M-%S)"
    
[[ $VERBOSE ]] && cat << EOF

────────────────────────────────────────────────────────────────────────────────
  Thunar custom actions setup
  ===========================

* creating symlink for thunar custom actions configuration XML file.
     from source: $THUNARCONF_SRC
  to destination: $THUNARCONF_DST

* current file will be saved as "$THUNARCONF_BAK"
────────────────────────────────────────────────────────────────────────────────

EOF
    
    if [ -f "$THUNARCONF_DST" ]; then         # is the repo file in place?
        if [ -f "$THUNARCONF_SRC" ]; then     # is the config file already in place?
            if [ -L "$THUNARCONF_SRC" ]; then # is the config file a symlink?
                echo "* removing symlink $THUNARCONF_SRC .."
                rm -v "$THUNARCONF_SRC"
            else
                echo "** moving existing file out of the way .."
                $MOVE "$THUNARCONF_SRC" "$THUNARCONF_BAK"
            fi
        fi
    
        # creating symlink from "$THUNARCONF_DST" to "$THUNARCONF_SRC"
        echo "** creating symlink .."
        ln -vsi "$THUNARCONF_DST" "$THUNARCONF_SRC"
        echo ""
    else
        echo "* error! $THUNARCONF_DST doesn't exist!"
        exit
    fi

    printf "\ndone!\n"
else
    printf "\n\n* Thunar doesn't seem to be installed. Skipping ..\n\n"
fi



# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## create symlink to zsh theme
echo "Symlinking zsh theme .."
OHMYZSH_THEMES="$DOTFILES_ROOT/oh-my-zsh/themes"

if [ -d "$OHMYZSH_THEMES" ]; then
    ln -vsi "$DOTFILES_ROOT/jonas.zsh-theme" \
          "$OHMYZSH_THEMES/jonas.zsh-theme"
else
    echo "* error! $OHMYZSH_THEMES doesn't exist!"
    echo "         make sure oh-my-zsh is installed."
fi
