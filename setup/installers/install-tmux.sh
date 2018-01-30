#! /usr/bin/env bash
# installer script for tmux plugins

set -euo pipefail

dir="$( cd "$( dirname "${BASH_SOURCE[0]}")" && pwd )"
setup_dir="$( dirname "$dir" )"
dotfiles_dir="$( dirname "$setup_dir")"

source "$dotfiles_dir/dotfiles-support"

run_tmux_installer() {
  display_message "Install tmux plugins..."
  tmux/plugins/tpm/bin/install_plugins
  display_message "...done with tmux plugins"
}

run_tmux_installer