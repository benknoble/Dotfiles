#! /bin/bash -
# git setup

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
  name="$(git config --global --get user.name)"
  email="$(git config --global --get user.email)"

  if [[ -z "$name" ]]; then
    echo "No previous user name"
    config user name
  else
    echo "Previous user name: $name"
    read -n 1 -p "Is [name = $name] ok [Y/n] ? " nameok && echo
    if [[ !("$nameok" =~ ^(y|Y)) ]]; then
      config user name
    fi
  fi
  echo

  if [[ -z "$email" ]]; then
    echo "No previous user email"
    config user email
  else
    echo "Previous user email: $email"
    read -n 1 -p "Is [email = $email] ok [Y/n] ? " emailok && echo
    if [[ !("$emailok" =~ ^(y|Y)) ]]; then
      config user email
    fi
  fi
}

echo "Configuring git..."
echo

[[ -e ~/.gitconfig ]] && {
  echo "Backing up gitconfig..."
  mv -f ~/.gitconfig ~/Dotfiles_old/gitconfig
  echo "...done backing up gitconfig"
  echo
}

# Check if Ben Knoble
read -n 1 -p "Are you Ben Knoble (@benknoble) [Y/n] ? " ben && echo
if [[ "$ben" =~ ^(y|Y) ]]; then
  # Symlink gitconfig
  echo "Symlinking gitconfig..."
  ln -s ~/Dotfiles/gitconfig ~/.gitconfig
else
  # Copy gitconfig
  echo "Copying gitconfig..."
  cp ~/Dotfiles/gitconfig ~/.gitconfig

  # Reconfigure user name, email address
  echo "Configure user name and email..."
  config_user_info
  echo "...done with user info"
fi

echo "...done with gitconfig"
echo

echo "...done configuring git"
