#! /usr/bin/env bash
# updates Dotfiles

set -euo pipefail

dir="$( cd "$( dirname "${BASH_SOURCE[0]}")" && pwd )"

source "$dir/dotfiles-support"

pull_master() {
  cd "$dir" \
    && git checkout master \
    && git pull origin master
}

has_brew() {
  which brew > /dev/null 2>&1
}

bundle_check() {
  brew bundle check
}


update() {
  if pull_master ; then
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
