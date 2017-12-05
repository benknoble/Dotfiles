#! /usr/bin/env bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/Dotfiles
############################

########## Variables

dir=~/Dotfiles                                                  # dotfiles directory
olddir=~/Dotfiles_old                                           # old dotfiles backup directory
# list of files/folders to symlink in homedir
declare -A files=(
  [bash_profile]=.bash_profile
  [vimrc]=.vimrc
  [bashrc]=.bashrc
  [inputrc]=.inputrc
  [gitignore_global]=.gitignore_global
  [vim]=.vim
  [tmux.conf]=.tmux.conf
  [gitshrc]=.gitshrc
  [ackrc]=.ackrc
)

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing Dotfiles in ~..."
mkdir -p "$olddir"
sleep 1
echo "...done"
echo

# clean out dotfiles_old
echo "Cleaning out $olddir to hold fresh backups..."
find ~/Dotfiles_old/ -not -path ~/Dotfiles_old/ -delete
sleep 1
echo "...done"
echo

# change to the dotfiles directory
echo "Changing to the $dir directory..."
cd "$dir" || { echo "Failed to find $dir"; exit 1; }
sleep 1
echo "...done"
echo

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in "${!files[@]}"; do
  echo "Moving ${files[$file]} from ~ to $olddir"
  mv ~/"${files[$file]}" "$olddir"/"${files[$file]}"
  sleep 1
  echo "Creating symlink to ${files[$file]} in home directory."
  ln -s "$dir"/"$file" ~/"${files[$file]}"
  sleep 1
  echo "Finished ${files[$file]}"
  sleep 1
  echo
done

echo "...done"
