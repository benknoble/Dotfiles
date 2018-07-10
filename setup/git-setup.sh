#! /usr/bin/env bash
# git setup

set -euo pipefail

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dotfiles_dir="$(dirname "$dir")"
dotfiles_old="${dotfiles_dir}_old"

gitconfig="$dotfiles_dir/links/gitconfig"

source "$dotfiles_dir/dotfiles-support"

backup_gitconfig() {
  if [[ -e ~/.gitconfig ]]; then
    display_message "Backing up gitconfig..."
    mv -f ~/.gitconfig "$dotfiles_old/gitconfig"
    display_message "...done backing up gitconfig"
  fi
}

symlink_gitconfig() {
  display_message "Symlinking gitconfig..."
  ln -Fivs "$gitconfig" ~/.gitconfig
  display_message "...done with gitconfig"
}

setup_git() {
  display_message "Configuring git..."
  backup_gitconfig
  symlink_gitconfig
  display_message "...done configuring git"
}

setup_git
