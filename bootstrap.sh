#! /usr/bin/env bash
# bootstrap the dotfiles into your home directory and install software

# bootstrap is not quite the correct term for this installer based on wikipedia,
# but it is more fun than 'setup.' The script will execute commands from the
# setup directory to get things running

# turn on "strict mode"
set -euo pipefail

dotfiles_dir="$( cd "$( dirname "${BASH_SOURCE[0]}")" && pwd )"
setup_dir="$dotfiles_dir/setup"

source "$dotfiles_dir/dotfiles-support"

confirm_bootstrap() {
  display_message "WARNING: Backups in the old directory (${dotfiles_dir}_old)
will be DELETED and OVERWRITTEN

If you want to keep them, abort and move them!

Are you sure you want to continue bootstrapping Dotfiles?"

  read -n 1 -p "[y/n]> " install && echo
  input_matches_yY "$install"
}

symlink_dotfiles() {
  display_message "Making symlinks to configuration files..."
  bash "$setup_dir/makesymlinks.sh"
  display_message "...done with symlinks"
}

install_software() {
  display_message "Running installers..."
  bash "$setup_dir/install-all.sh"
  display_message "...done with installers"
}

setup_git() {
  display_message "Setting up git..."
  bash "$setup_dir/git-setup.sh"
  display_message "...done with git"
}


bootstrap() {
  display_message "Bootstrapping Dotfiles..."
  symlink_dotfiles
  install_software
  setup_git
  display_message "...done bootstrapping"
}

if confirm_bootstrap; then
  bootstrap
else
  display_message "Aborting bootrap"
fi
