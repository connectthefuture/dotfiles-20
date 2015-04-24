#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles
# in ~/dotfiles                     http://blog.smalleycreative.com/tutorials/
# using-git-and-github-to-manage-your-dotfiles/
############################

## DENNA

dotfiles_dir="$(pwd)"                  # assume we are in the dotfiles directory
dotfiles_old=""$dotfiles_dir""/dotfiles_old""    # old dotfiles backup directory

# These files are _the_ dotfiles
files="bashrc vimrc vim zshrc oh-my-zsh gitconfig"   

# create dotfiles_old in homedir
echo "Creating $dotfiles_old for backup of any existing dotfiles in "$HOME" .."
mkdir -pv "$dotfiles_old"
echo ".. done"

# change to the dotfiles directory
echo "Changing to the $dotfiles_dir directory .."
cd $dotfiles_dir
echo ".. done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv -v ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

# create symlink to zsh theme
echo "Symlink zsh theme .."
ln -s $dir/jonas.zsh-theme $dir/oh-my-zsh/themes/jonas.zsh-theme
