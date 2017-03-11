#! /bin/bash
############################
#.make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/Dotfiles
############################

########## Variables

dir=~/Dotfiles                       # dotfiles directory
olddir=~/Dotfiles_old                # old dotfiles backup directory
files="bash_profile vimrc bashrc"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing Dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo "Moving .$file from ~ to $olddir"
    mv ~/.$file $olddir/$file
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done
