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
CONFIGFILES="bashrc vimrc vim zshrc oh-my-zsh gitconfig"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
cat << EOF
  ──────────────────────────────────────────────────────────────────────────────
  Dotfiles setup script
  =====================

* started with root "$DOTFILES_ROOT"
* creating symlinks from "$HOME" to "$DOTFILES_ROOT"
  for dotfiles: "$CONFIGFILES"
* current dotfiles will be backed up to "$BACKUP_ARCHIVE"

EOF

mkdir -pvv "$TEMP_DIR"                   # setup a folder for temporary storage
cd "$HOME"

for file in $CONFIGFILES;            
do
    if [ -f ".$file" ];                  # check for current config files
    then                                 # if present move to temporary storage
        echo "** moving ".$file" out of the way .."
        $MOVE ".$file" "$TEMP_DIR"        
        echo ""
    fi

    if [ -f "$DOTFILES_ROOT/$file" ];    # check that file is in repo directory
    then                                 # if not, print error and die
        echo "* creating symlink from "$HOME/.$file" to "$DOTFILES_ROOT/$file" .."
        ln -vsi "$DOTFILES_ROOT/$file" "$HOME/.$file"
        echo ""
    else
        echo "** error! $DOTFILES_ROOT/$file doesn't exist!"
        exit
    fi
done

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
cat << EOF

* done ..
** archiving the old dotfiles ..

EOF

# this assumes more than a minute passes between runs .. file exists error?
tar vcfz "$BACKUP_ARCHIVE" -C "$TEMP_DIR" .

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

# symlink thunar custom actions config file
THUNARCONF_DST="$HOME/.config/Thunar/uca.xml"
THUNARCONF_SRC="$DOTFILES_ROOT/thunar-custom.xml"

if [ -f "$THUNARCONF_SRC" ];
then
    echo "$THUNARCONF_SRC exists .."

    if [ -f "$THUNARCONF_DST" ];    # is the config file already in place?
    then
        echo "$THUNARCONF_DST exists .."
        echo "** moving existing file out of the way .."
        $MOVE "$THUNARCONF_DST" ""$THUNARCONF_DST"_$(date +%Y-%m-%d_%H-%M-%S)"
        echo ""
    fi

#   echo "* creating symlink from "$THUNARCONF_DST" to "$THUNARCONF_SRC" .."
    echo "** creating symlink .."
    ln -vsi "$THUNARCONF_SRC" "$THUNARCONF_DST"
    echo ""
else
    echo "** error! $THUNARCONF_SRC doesn't exist!"
    exit
fi



## create symlink to zsh theme
#echo "Symlink zsh theme .."
#ln -s $dir/jonas.zsh-theme $dir/oh-my-zsh/themes/jonas.zsh-theme
