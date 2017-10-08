#! /bin/bash -
# installer script for brew and certain formulae

_install_brew() {
  if ! /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" ; then
    echo "Brew installation failed!" >&2
    exit 1
  fi
}

_set_shell() {
  echo "Add $1 to allowed shells"
  sudo bash -c "echo $1 >> /etc/shells"
  echo "Change default shell to $1"
  chsh -s "$1" "$USER"
}

echo
echo "Install Brew..."

read -n 1 -p "Install Brew [Y/n]? " installBrew && echo
if [[ "$installBrew" =~ ^(y|Y) ]]; then
  echo "Installing Brew..."

  _install_brew
  brew tap Homebrew/bundle
  brew bundle install
  bash_path=/usr/local/bin/bash
  [[ -x "$bash_path" ]] && _set_shell "$bash_path"

else
  echo "Skipping Brew..."
fi

echo "...done with Brew"
echo
