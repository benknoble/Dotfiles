#! /usr/bin/env bash
# This script creates symlinks from the home directory to dotfiles

set -euo pipefail

dir="$( cd "$( dirname "${BASH_SOURCE[0]}")" && pwd )"
dotfiles_dir="$(dirname "$dir")"
olddir="${dotfiles_dir}_old"
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
  [tmux]=.tmux
)

source "$dotfiles_dir/dotfiles-support"

create_backup_dir() {
  display_message "Creating $olddir for backup of any existing files in $HOME..."
  mkdir -p "$olddir"
  display_message "...done"
}

clean_backup_dir() {
  display_message "Cleaning out $olddir to hold fresh backups..."
  find "$olddir" -not -path "$olddir" -delete
  display_message "...done"
}

verify_directory() {
  display_message "Checking for the $dotfiles_dir directory..."
  if [[ "$PWD" == "$dotfiles_dir" ]]; then
    display_message "...Found $dotfiles_dir directory"
    true
  else
    display_message "...Failed to find $dotfiles_dir"
    false
  fi
}

backup_file() {
  [[ -e ~/"${files[$1]}" ]] && mv ~/"${files[$1]}" "$olddir"/"${files[$1]}"
}

symlink_file() {
  ln -s "$dotfiles_dir"/"$1" ~/"${files[$1]}"
}

# handle the file by moving it to backup and symlinking
# args: 1: dotfile key (that is, the name it has in this repo)
handle_file() {
  display_message "Starting ${files[$1]}..."
  display_message "Moving ${files[$1]} from $HOME to $olddir"
  backup_file "$1"
  display_message "Creating symlink to ${files[$1]} in $HOME"
  symlink_file "$1"
  display_message "...Finished ${files[$1]}"
  sleep 1
}

handle_files() {
  for file in "${!files[@]}"; do
    handle_file "$file"
  done
}

makesymlinks() {
  display_message "Making symlinks..."
  if ! verify_directory ; then
    exit
  fi
  create_backup_dir
  clean_backup_dir
  handle_files
  display_message "...done making symlinks"
}

makesymlinks
