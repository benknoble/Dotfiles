#! /usr/bin/env bash
# installer script for git extras

set -euo pipefail

dir="$( cd "$( dirname "${BASH_SOURCE[0]}")" && pwd )"
setup_dir="$( dirname "$dir" )"
dotfiles_dir="$( dirname "$setup_dir")"

path_to_gitk_config="${dotfiles_dir}/Dracula/gitk/gitk"

source "$dotfiles_dir/dotfiles-support"

install_git_prompt_completion() {
  display_message "Previous git extras (git prompt and git completion) are now
  included by installing git via brew and will be sourced if installed;
  otherwise, they will not be used."
}

install_dotfile_hooks() {
  display_message "Setting up dotfile hooks..."
  remove_old_hooks
  link_hooks
  display_message "...done with dotfile hooks"
}

remove_old_hooks() {
  display_message "Removing hooks in .git/hooks..."
  [[ -e .git/hooks ]] && {
    [[ -L .git/hooks ]] && { rm -fv .git/hooks; }
    [[ -d .git/hooks ]] && { rm -fv .git/hooks/*; rmdir .git/hooks; }
  }
  display_message "...done removing hooks"
}

link_hooks() {
  display_message "Linking in hooks..."
  ln -Fivs ~/Dotfiles/hooks/ .git/
  display_message "...done linking in hooks"
}

gitk_submodule_exists() {
  [[ -r "$path_to_gitk_config" ]]
}

copy_gitk() {
  display_message "Copying gitk dracula theme..."
  if gitk_submodule_exists ; then
    cp -iv -- "$path_to_gitk_config" \
      "${XDG_CONFIG_HOME:-$HOME/.config}/git/gitk"
    display_message "...Done copying gitk dracula theme"
  else
    display_message "...no gitk dracula theme found at $path_to_gitk_config"
  fi
}

install_git_extras() {
  display_message "Install git extras..."
  install_git_prompt_completion
  install_dotfile_hooks
  copy_gitk
  display_message "...done with git extras"
}

install_git_extras
