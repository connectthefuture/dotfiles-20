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

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
cat << EOF
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

mkdir -pvv "$TEMP_DIR"                   # setup a folder for temporary storage
cd "$HOME"

for file in $CONFIGFILES;
do
    if [ -f ".$file" ];                  # check for current config files
    then                                 # if present move to temporary storage
        echo "** moving ".$file" out of the way .."
        $MOVE "$HOME/.$file" "$TEMP_DIR"
    fi

    if [ -e "$DOTFILES_ROOT/$file" ];    # check that file is in repo directory
    then                                 # if not, print error and die
        # create symlink from "$HOME/.$file" to "$DOTFILES_ROOT/$file"
        echo "** creating symlink .."
        ln -vsi "$DOTFILES_ROOT/$file" "$HOME/.$file"
        echo ""
    else
        echo "* error! $DOTFILES_ROOT/$file doesn't exist!"
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

cat << EOF

* done ..
** removing temporary files ..

EOF

rm -vrf "$TEMP_DIR"

echo ""
echo "* done .."


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# symlink thunar custom actions config file
THUNARCONF_DST="$HOME/.config/Thunar/uca.xml"
THUNARCONF_SRC="$DOTFILES_ROOT/thunar-custom.xml"
THUNARCONF_BAK=""$THUNARCONF_DST"_$(date +%Y-%m-%d_%H-%M-%S)"

cat << EOF

────────────────────────────────────────────────────────────────────────────────
  Thunar custom actions setup
  ===========================

* creating symlink for thunar custom actions configuration XML file.
     from source: $THUNARCONF_DST
  to destination: $THUNARCONF_SRC
  
* current file will be saved as "$THUNARCONF_BAK"
────────────────────────────────────────────────────────────────────────────────
EOF

if [ -f "$THUNARCONF_SRC" ];        # is the repo file in place?
then

    if [ -f "$THUNARCONF_DST" ];    # is the config file already in place?
    then
        echo "** moving existing file out of the way .."
        $MOVE "$THUNARCONF_DST" "$THUNARCONF_BAK"
    fi

    # creating symlink from "$THUNARCONF_DST" to "$THUNARCONF_SRC"
    echo "** creating symlink .."
    ln -vsi "$THUNARCONF_SRC" "$THUNARCONF_DST"
    echo ""
else
    echo "* error! $THUNARCONF_SRC doesn't exist!"
    exit
fi


echo ""
echo "done!"

## create symlink to zsh theme
#echo "Symlink zsh theme .."
#ln -s $dir/jonas.zsh-theme $dir/oh-my-zsh/themes/jonas.zsh-theme
