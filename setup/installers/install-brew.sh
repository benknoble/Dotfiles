#! /usr/bin/env bash
# installer script for brew and certain formulae

set -euo pipefail

dir="$( cd "$( dirname "${BASH_SOURCE[0]}")" && pwd )"
setup_dir="$( dirname "$dir" )"
dotfiles_dir="$( dirname "$setup_dir")"
BREWFILE="$dotfiles_dir/brew/Brewfile"

source "$dotfiles_dir/dotfiles-support"

install_brew() {
  if ! /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" ; then
    display_message "Brew installation failed!"
    exit 1
  fi
  bundle
}

bundle() {
  brew tap Homebrew/bundle
  brew bundle install --file="$BREWFILE"
}

set_shell() {
  display_message "Add $1 to allowed shells (sudo password required)"
  sudo bash -c "echo $1 >> /etc/shells"
  display_message "Change default shell to $1"
  chsh -s "$1" "$USER"
}

confirm_homebrew() {
  read -n 1 -p "Install brew [Y/n]? " installBrew && echo
  input_matches_yY "$installBrew"
}

homebrew() {
  display_message "Installing brew..."
  if confirm_homebrew ; then
    install_brew
    local bash_path=/usr/local/bin/bash
    [[ -x "$bash_path" ]] && set_shell "$bash_path"
  else
    display_message "Skipping Brew..."
  fi
  display_message "...done with brew"
}

homebrew
