#! /bin/bash -
# installer script for brew and certain formulae

_install_brew() {
  if ! /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" ; then
    echo "Brew installation failed!" >&2
    exit 1
  fi
}

echo
echo "Install Brew..."

read -n 1 -p "Install Brew [Y/n]? " installBrew && echo
if [[ "$installBrew" =~ ^(y|Y) ]]; then
  echo "Installing Brew..."

  _install_brew
  brew tap Homebrew/bundle
  brew bundle install

else
  echo "Skipping Brew..."
fi

echo "...done with Brew"
echo
