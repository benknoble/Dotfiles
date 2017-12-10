#! /usr/bin/env bash
# installer script for git extras

set -euo pipefail

dir="$( cd "$( dirname "${BASH_SOURCE[0]}")" && pwd )"
setup_dir="$( dirname "$dir" )"
dotfiles_dir="$( dirname "$setup_dir")"

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

install_git_extras() {
  display_message "Install git extras..."
  install_git_prompt_completion
  install_dotfile_hooks
  display_message "...done with git extras"
}

install_git_extras
