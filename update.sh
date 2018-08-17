#! /usr/bin/env bash
# updates Dotfiles

set -euo pipefail

dir="$( cd "$( dirname "${BASH_SOURCE[0]}")" && pwd )"

source "$dir/dotfiles-support"

if [[ -e ~/.Brewfile ]]; then
  BREWFILE=~/.Brewfile
else
  BREWFILE="$dir/brew/Brewfile"
fi

pull_master() {
  cd "$dir" \
    && git checkout master \
    && git pull --recurse-submodules=on-demand origin master
}

update_submodules() {
  cd "$dir" \
    && git submodule sync \
    && git submodule update
}

has_brew() {
  command -v brew > /dev/null 2>&1
}

bundle_check() {
  # the "or true" is necessary to prevent a bundle issue from stopping the rest
  # of the rest update
  brew bundle check --file="$BREWFILE" || true
}

update() {
  if pull_master && update_submodules ; then
    display_message "Updated"
    has_brew && bundle_check
    display_message "Type 'reload' to reload updates"
    display_message "You may need to logout of the terminal and login for
    changes to take full effect"
  else
    display_message "Update failed"
  fi
}

update
