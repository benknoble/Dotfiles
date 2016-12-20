#!/bin/bash
# installer script for Pathogen and certain vim plugins

echo "INSTALL CUSTOM VIM"

#install pathogen
read -n 1 -p "Install Pathogen for Vim [Y/n]? " installPathogen && echo
if [[ $installPathogen =~ ^(y|Y) ]]; then
	echo "Installing Pathogen..."
	(mkdir -p ~/.vim/autoload ~/.vim/bundle && \
		curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim) || echo "Pathogen installation failed"

	#install vim-airline
	read -n 1 -p "Install Vim-Airline [Y/n]? " installVAirline && echo
	if [[ $installVAirline =~ ^(y|Y) ]]; then
		echo "Installing Vim-Airline..."
		(git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline && \
			vim +'Helptags' +'q') || echo "Vim-Airline installation failed"

		#install vim-airline-themes
		read -n 1 -p "Install Vim-Airline-Themes [Y/n]? " installVAThemes && echo
		if [[ $installVAThemes =~ ^(y|Y) ]]; then
			echo "Installing Vim-Airline-Themes..."
			(git clone https://github.com/vim-airline/vim-airline-themes ~/.vim/bundle/vim-airline-themes) || echo "Vim-Airline-Themes installation failed"
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
		(git clone https://github.com/tpope/vim-fugitive ~/.vim/bundle/vim-fugitive && \
			vim +'helptags ~/.vim/bundle/vim-fugitive/doc' +'q') || echo "Vim-Fugitive installation failed"
	else
		echo "Skipping Vim-Fugitive..."
	fi

	#install syntastic
	read -n 1 -p "Install Syntastic [Y/n]? " installSyntastic && echo
	if [[ $installSyntastic =~ ^(y|Y) ]]; then
		echo "Installing Syntastic..."
		(git clone --depth=1 https://github.com/vim-syntastic/syntastic.git ~/.vim/bundle/vim-syntastic && \
			vim +'Helptags' +'q') || echo "Syntastic installation failed"
	else
		echo "Skipping Syntastic..."
	fi
else
	echo "Skipping Pathogen..."
fi
