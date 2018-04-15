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

update_submodules() {
  cd "$dir" \
    && git submodule update
}

has_brew() {
  which brew > /dev/null 2>&1
}

bundle_check() {
  # the "or true" is necessary to prevent a bundle issue from stopping the rest
  # of the rest update
  brew bundle check || true
}

tmux_plugin_update() {
  local tpm=tmux/plugins/tpm/bin
  "$tpm"/clean_plugins
  "$tpm"/update_plugins all
}

update() {
  if pull_master && update_submodules ; then
    display_message "Updated"
    display_message "To pull in upstream submodules, type
    'git submodule update --init'"
    has_brew && bundle_check
    tmux_plugin_update
    display_message "Type 'reload' to reload updates"
    display_message "You may need to logout of the terminal and login for
    changes to take full effect"
  else
    display_message "Update failed"
  fi
}

update
