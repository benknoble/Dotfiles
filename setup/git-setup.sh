#! /usr/bin/env bash
# git setup

set -euo pipefail

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dotfiles_dir="$(dirname "$dir")"
dotfiles_old="${dotfiles_dir}_old"

gitconfig="$dotfiles_dir/links/gitconfig"

source "$dotfiles_dir/dotfiles-support"

# config function
# Args: 1:section 2:key
# Usage: config user name
# -- Prompts for user name and then does git config --global user.name $input
config() {
  read -p "Enter git $1 $2 > " u_in
  git config --global "$1.$2" "$u_in"
  echo "git $1 $2 = $u_in"
}

# Usage: config_user_info
# -- Configures user information for someone other than Ben Knoble
config_user_info() {
  local name
  name="$(git config --global --get user.name)"
  local email
  email="$(git config --global --get user.email)"

  if [[ -z "$name" ]]; then
    display_message "No previous user name"
    config user name
  else
    display_message "Previous user name: $name"
    read -n 1 -p "Is [name = $name] ok [Y/n] ? " nameok && echo
    if ! input_matches_yY "$nameok"; then
      config user name
    fi
  fi

  if [[ -z "$email" ]]; then
    display_message "No previous user email"
    config user email
  else
    display_message "Previous user email: $email"
    read -n 1 -p "Is [email = $email] ok [Y/n] ? " emailok && echo
    if ! input_matches_yY "$emailok"; then
      config user email
    fi
  fi
}

backup_gitconfig() {
  if [[ -e ~/.gitconfig ]]; then
    display_message "Backing up gitconfig..."
    mv -f ~/.gitconfig "$dotfiles_old/gitconfig"
    display_message "...done backing up gitconfig"
  fi
}

symlink_gitconfig() {
  display_message "Symlinking gitconfig..."
  ln -Fivs "$gitconfig" ~/.gitconfig
  display_message "...done with gitconfig"
}

copy_gitconfig() {
  display_message "Copying gitconfig..."
  cp "$gitconfig" ~/.gitconfig
  display_message "...done with gitconfig"
}

reconfigure_name_email() {
  display_message "Configure user name and email..."
  config_user_info
  display_message "...done with user info"
}

is_ben_knoble() {
  read -n 1 -p "Are you Ben Knoble (@benknoble) [Y/n] ? " ben && echo
  input_matches_yY "$ben"
}

setup_git() {
  display_message "Configuring git..."
  backup_gitconfig
  if is_ben_knoble; then
    symlink_gitconfig
  else
    copy_gitconfig
    reconfigure_name_email
  fi
  display_message "...done configuring git"
}

setup_git
