#!/bin/bash
# installer script for brew and certain formulae

echo "INSTALL CUSTOM VIM"

#install pathogen
read -n 1 -p "Install Pathogen for Vim [Y/n]? " installPathogen && echo
if [[ $installPathogen =~ ^(y|Y) ]]; then
	echo "Installing Pathogen..."
	#install vim-airline
	read -n 1 -p "Install Vim-Airline [Y/n]? " installVAirline && echo
	if [[ $installVAirline =~ ^(y|Y) ]]; then
		echo "Installing Vim-Airline..."
		#install vim-airline-themes
		read -n 1 -p "Install Vim-Airline-Themes [Y/n]? " installVAThemes && echo
		if [[ $installVAThemes =~ ^(y|Y) ]]; then
			echo "Installing Vim-Airline-Themes..."
		else
			echo "Skipping Vim-Airline-Themes..."
		fi
	else
		echo "Skipping Vim-Airline..."
	fi

	#install vim-fugitive
	read -n 1 -p "Install Vim-Fugitive [Y/n]? " installVFugitive && echo
	if [[ $installVFugitive =~ ^(y|Y) ]]; then
		echo "Installing Vim-Fugitive..."
	else
		echo "Skipping Vim-Fugitive..."
	fi
else
	echo "Skipping Pathogen..."
fi
