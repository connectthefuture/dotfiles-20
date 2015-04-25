#!/bin/bash
#   ______________________________________________________________________

#   DOTFILES SETUP SCRIPT
#                               written by Jonas Sjöberg for *personal* use
#                                                  Last updated: 2015-04-25
#   ______________________________________________________________________

#   Should only ever need to be executed after a clean reinstall of the home
#   directory.  Replaces the standard "/home/user/.configfile"-files with
#   symlinks to files kept under version control.in this here repository.
#   Some error checks are performed but please note that I WILL NOT take any
#   responsability for anything you might do with this script. Be careful.
#

#cd "$(dirname "$0")/.."             # this probably lands us in $HOME
DOTFILES_ROOT=$(pwd)
TEMP_DIR="$HOME/temporary_dotfiles"
BACKUP_DIR="$HOME/"

# These files are *the* dotfiles!
CONFIGFILES="bashrc vimrc vim zshrc oh-my-zsh gitconfig"

# print some text
cat << EOF
  ──────────────────────────────────────────────────────────────────────────────
  Dotfiles setup script
  =====================

* started with root "$DOTFILES_ROOT"
* backing up any .dotfiles already in "$HOME" ..

EOF

mkdir -pvv "$TEMP_DIR"                   # setup a folder for temporary storage
cd "$HOME"

for file in $CONFIGFILES;            
do
    if [ -f ".$file" ];                  # check for current config files
    then                                 # if present move to temporary storage
        echo "* moving ".$file" out of the way .."
        mv -vni ".$file" "$TEMP_DIR"        
        echo ""
    fi

    if [ -f "$DOTFILES_ROOT/$file" ];
    then
        echo "* creating symlink to "$DOTFILES_ROOT/$file" .."
        ln -vsi "$DOTFILES_ROOT/$file" "$HOME/.$file"
        echo ""
    fi
done

# print some text
cat << EOF

** done ..
** creating .tar.gz archive with old dotfiles ..

EOF

tar vcfz ""$BACKUP_DIR"dotfiles-$(date +%Y-%m-%d_%H-%M-%S).tar.gz" "$TEMP_DIR"
#
# # create dotfiles_old in homedir
# echo "Creating $dotfiles_old for backup of any existing dotfiles in "$HOME" .."
# mkdir -pv "$dotfiles_old"
# echo ".. done"
#
# # change to the dotfiles directory
# # echo "Changing to the $dotfiles_dir directory .."
# # cd $dotfiles_dir
# # echo ".. done"
#
# # move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
# for file in $files; do
#     echo "Moving any existing dotfiles from ~ to $olddir"
#     echo "mv -v ~/.$file ~/dotfiles_old/"
#     echo "Creating symlink to $file in home directory."
#     echo "ln -s ""$dotfilesdir"/"$file"" ~/."$file""
# done
#
# # create symlink to zsh theme
# echo "Symlink zsh theme .."
# #ln -s $dir/jonas.zsh-theme $dir/oh-my-zsh/themes/jonas.zsh-theme
