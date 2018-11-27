#! /usr/bin/env bash
# installer script for git extras

set -euo pipefail

dir="$( cd "$( dirname "${BASH_SOURCE[0]}")" && pwd )"
dotfiles_dir="$DOTFILES"

path_to_gitk_config="${dotfiles_dir}/Dracula/gitk/gitk"
user_gitk_config="${XDG_CONFIG_HOME:-$HOME/.config}/git/gitk"

source "$SUPPORT"

gitk_submodule_exists() {
  [[ -r "$path_to_gitk_config" ]]
}

copy_gitk() {
  display_message "Copying gitk dracula theme..."
  if gitk_submodule_exists ; then
    mkdir -p "$( dirname "$user_gitk_config" )"
    cp -iv -- "$path_to_gitk_config" "$user_gitk_config"
    display_message "...Done copying gitk dracula theme"
  else
    display_message "...no gitk dracula theme found at $path_to_gitk_config"
  fi
}

install_git_extras() {
  display_message "Install git extras..."
  copy_gitk
  display_message "...done with git extras"
}

install_git_extras
