#!/bin/bash
#   ______________________________________________________________________

#   DOTFILES SETUP SCRIPT
#                               written by Jonas Sjöberg for *personal* use
#                                                  Last updated: 2015-04-26
#   ______________________________________________________________________

#   Should only ever need to be executed after a clean reinstall of the home
#   directory.  Replaces the standard "/home/user/.configfile"-files with
#   symlinks to files kept under version control in this here repository.
#   Some error checks are performed but please note that I WILL NOT take any
#   responsability for anything you might do with this script. Be careful.
#

DOTFILES_ROOT=$(pwd)
TEMP_DIR="$HOME/temporary_dotfiles"
BACKUP_ARCHIVE="$HOME/dotfiles_$(date +%Y-%m-%d_%H-%M-%S).tar.gz"
MOVE="mv -vni"

# These files are *the* dotfiles!
#CONFIGFILES="bashrc vimrc vim zshrc oh-my-zsh gitconfig"
CONFIGFILES="bashrc vimrc vim zshrc gitconfig"

# Be verbose. Prints debug information.
VERBOSE=true


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
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

echo "\n* done .."

if [ -d "$TEMP_DIR" ]; then
    echo "\n** archiving the old dotfiles .."

    # this assumes more than a minute passes between runs .. file exists error?
    tar vcfz "$BACKUP_ARCHIVE" -C "$TEMP_DIR" .

    echo "\n* done .."
    echo "** removing temporary files .."
    rm -vrf "$TEMP_DIR"
    
    echo "\n* done .."
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# symlink thunar custom actions config file
THUNARCONF_SRC="$HOME/.config/Thunar/uca.xml"       # this file is a link ..
THUNARCONF_DST="$DOTFILES_ROOT/thunar-custom.xml"   # .. to this file
THUNARCONF_BAK=""$THUNARCONF_SRC"_$(date +%Y-%m-%d_%H-%M-%S)"

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


echo ""
echo "done!"

## create symlink to zsh theme
#echo "Symlink zsh theme .."
#ln -s $dir/jonas.zsh-theme $dir/oh-my-zsh/themes/jonas.zsh-theme
