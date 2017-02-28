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
        (git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline) || echo "Vim-Airline installation failed"

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
        (git clone https://github.com/tpope/vim-fugitive ~/.vim/bundle/vim-fugitive) || echo "Vim-Fugitive installation failed"
    else
        echo "Skipping Vim-Fugitive..."
    fi

    #install syntastic
    read -n 1 -p "Install Syntastic [Y/n]? " installSyntastic && echo
    if [[ $installSyntastic =~ ^(y|Y) ]]; then
        echo "Installing Syntastic..."
        (git clone --depth=1 https://github.com/vim-syntastic/syntastic.git ~/.vim/bundle/vim-syntastic) || echo "Syntastic installation failed"
    else
        echo "Skipping Syntastic..."
    fi

    #install ctrl-p
    read -n 1 -p "Install Ctrl-P [Y/n]? " installCP && echo
    if [[ $installCP =~ ^(y|Y) ]]; then
        echo "Installing Ctrl-P..."
        (git clone https://github.com/ctrlpvim/ctrlp.vim.git ~/.vim/bundle/vim-ctrlp) || echo "Ctrl-P installation failed"
    else
        echo "Skipping Ctrl-P..."
    fi

    #install auto-pairs
    read -n 1 -p "Install Auto-Pairs [Y/n]? " installAP && echo
    if [[ $installAP =~ ^(y|Y) ]]; then
        echo "Installing Auto-Pairs..."
        (git clone git://github.com/jiangmiao/auto-pairs.git ~/.vim/bundle/vim-auto-pairs) || echo "Auto-Pairs installation failed"
    else
        echo "Skipping Auto-Pairs..."
    fi

    #install invaders
    read -n 1 -p "Install Invaders [Y/n]? " installInv && echo
    if [[ $installInv =~ ^(y|Y) ]]; then
        echo "Installing Invaders..."
        (git clone https://github.com/mattn/invader-vim.git vim-invader) || echo "Invaders installation failed"
    else
        echo "Skipping Invaders..."
    fi
else
    echo "Skipping Pathogen..."
fi
