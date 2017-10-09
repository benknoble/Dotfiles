#! /usr/bin/env bash
# bootstrap is not quite the correct term for this installer based on wikipedia,
# but it is more fun than 'setup.' The script will execute commands from the
# setup directory to get things running

echo
echo "Bootstrapping Dotfiles..."
echo

echo "Making symlinks to configuration files..."
echo
echo "WARNING: Backups in the old directory (~/Dotfiles_old)
will be DELETED and OVERWRITTEN

If you want to keep them, abort and move them!

Are you sure you want to continue bootstrapping Dotfiles? "
read -n 1 -p "[y/n]> " install && echo
[[ "$install" =~ ^(y|Y) ]] || {
  echo "Aborting installation..."
  exit 1
}
echo
bash ~/Dotfiles/setup/makesymlinks.sh
echo
echo "...done with symlinks"
echo

echo "Running installers..."
echo
bash ~/Dotfiles/setup/install-all.sh
echo
echo "...done with installers"
echo

echo "Setting up git..."
echo
bash ~/Dotfiles/setup/git-setup.sh
echo
echo "...done with git"

echo
echo "...done bootstrapping"
