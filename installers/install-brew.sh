#!/bin/bash
# installer script for brew and certain formulae

echo "INSTALL BREW"

read -n 1 -p "Install Brew [Y/n]? " installBrew && echo
if [[ $installBrew =~ ^(y|Y) ]]; then
	echo "Installing Brew..."
	(/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)") || echo "Brew installation failed"

	#install cask
	read -n 1 -p "Install Cask [Y/n]? " installCask && echo
	if [[ $installCask =~ ^(y|Y) ]]; then
		echo "Installing Cask..."
		(brew tap caskroom/cask) || echo "Brew/Cask installation failed"
	else
		echo "Skipping Cask..."
	fi

	#install brew vim
	read -n 1 -p "Install Vim via Brew [Y/n]? " installVim && echo
	if [[ $installVim =~ ^(y|Y) ]]; then
		echo "Installing Vim..."
		(brew install vim) || echo "Brew/Vim installation failed"
	else
		echo "Skipping Vim..."
	fi

	#install brew git
	read -n 1 -p "Install Git via Brew [Y/n]? " installGit && echo
	if [[ $installGit =~ ^(y|Y) ]]; then
		echo "Installing Git..."
		(brew install git) || echo "Brew/Git installation failed"
	else
		echo "Skipping Git..."
	fi
else
	echo "Skipping Brew..."
fi
