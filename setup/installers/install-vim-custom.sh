#! /usr/bin/env bash
# installer script for certain vim plugins

set -euo pipefail

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
setup_dir="$( dirname "$dir" )"
dotfiles_dir="$( dirname "$setup_dir")"

source "$dotfiles_dir/dotfiles-support"

install_vim_plugins() {
  display_message 'Previous vim plugins are now included as submodules. If you
  cloned using the `--recursive` option, they have been properly cloned
  symlinked with the vim directory. If not, you will need `git submodule init;
  git submodule update`.'
}

install_vim_pieces() {
  display_message "Install custom vim..."
  install_vim_plugins
  display_message "...done with custom vim"
}

install_vim_pieces
