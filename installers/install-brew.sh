#!/bin/bash
# installer script for brew and certain formulae

echo "INSTALL BREW"

read -n 1 -p "Install Brew [Y/n]? " installBrew && echo
if [[ $installBrew =~ ^(y|Y) ]]; then
	echo "Installing Brew..."

	#install cask
	read -n 1 -p "Install Cask [Y/n]? " installCask && echo
	if [[ $installCask =~ ^(y|Y) ]]; then
		echo "Installing Cask..."
	else
		echo "Skipping Cask..."
	fi

	#install brew vim
	read -n 1 -p "Install Vim via Brew [Y/n]? " installVim && echo
	if [[ $installVim =~ ^(y|Y) ]]; then
		echo "Installing Vim..."
	else
		echo "Skipping Vim..."
	fi

	#install brew git
	read -n 1 -p "Install Git via Brew [Y/n]? " installGit && echo
	if [[ $installGit =~ ^(y|Y) ]]; then
		echo "Installing Git..."
	else
		echo "Skipping Git..."
	fi
else
	echo "Skipping Brew..."
fi
