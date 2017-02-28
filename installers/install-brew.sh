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

        #install mactex
        read -n 1 -p "Install Mactex via Cask [Y/n]? " installTex && echo
        if [[ $installTex =~ ^(y|Y) ]]; then
            echo "Installing Mactex..."
            (brew cask install mactex) || echo "Brew/Cask/Mactex installation failed"
        else
            echo "Skipping Mactex..."
        fi
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

    #install and configure bash 4.0
    read -n 1 -p "Install Bash 4.0 via Brew (admin priviledge required for some steps) [Y/n]? " installBash && echo
    if [[ $installBash =~ ^(y|Y) ]]; then
        echo "Installing Bash..."
        (brew install bash) || echo "Brew/Bash installation failed"
        echo "Add /usr/local/bin/bash to allowed shells"
        sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
        echo "Change default shell to /usr/local/bin/bash"
        chsh -s /usr/local/bin/bash "$USER"
    else
        echo "Skipping Bash..."
    fi

    #install archey
    read -n 1 -p "Install Archey via Brew [Y/n]? " installArchey && echo
    if [[ $installArchey =~ ^(y|Y) ]]; then
        echo "Installing Archey..."
        (brew install archey) || echo "Brew/Archey installation failed"
    else
        echo "Skipping Archey..."
    fi
else
    echo "Skipping Brew..."
fi
