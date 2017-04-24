#! /bin/bash
# bootstrap is not quite the correct term for this installer based on wikipedia,
# but it is more fun than 'setup.' The script will execute commands from the
# setup directory to get things running

echo "Bootstrapping Dotfiles..."
echo
echo "Making symlinks to configuration files..."
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
