#!/bin/bash
#| =~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~
#| DOTFILES SETUP SCRIPT
#| ---------------------
#| Should only need to run after a clean reinstall of the home directory.
#| Replaces the standard "/home/user/.configfile" files with symlinks to
#| files kept in this here repository under version control.
#|
#|
#| =~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~


cd "$(dirname "$0")/.."             # this probably lands us in $HOME
DOTFILES_ROOT=$(pwd)
TEMP_DIR="$HOME/temporary_dotfiles"
BACKUP_DIR="$HOME"

# These files are *the* dotfiles!
CONFIGFILES="bashrc vimrc vim zshrc oh-my-zsh gitconfig"   

# print some text
cat << EOF
────────────────────────────────────────────────────────────────────────────────
                           Dotfiles setup script 
                           =====================

 * started with root "$DOTFILES_ROOT"
 * backing up any .dotfiles already in "$HOME" ..

EOF


mkdir -pvv "$TEMP_DIR"               # setup a folder for temporary storage

# cd "$DOTFILES_ROOT"                    # get in position ..
# mkdir -pv "$TEMP_DIR"-               # setup a folder for temporary storage
# echo ""
# 
# for file in $CONFIGFILES; do           # check for current config files
#     if [ -f "$file" ];           # if present move to temporary storage 
#     then
#         echo "* moving "$file" out of the way .."
#         mv -nv "$file" "$TEMP_DIR"
#     fi
# 
#     if [ -f "$DOTFILES_ROOT/$file" ];
#     then
# 
#     fi
# done
# 
# tar vcfz ""$BACKUP_DIR"dotfiles-$(date +%Y-%m-%d_%H-%M-%S).tar.gz" "$TEMP_DIR/*"
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
