#! /bin/bash
# installer script for brew and certain formulae

echo
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

    #install smlnj
    read -n 1 -p "Install SML/NJ via Brew [Y/n]? " installsmlnj && echo
    if [[ $installsmlnj =~ ^(y|Y) ]]; then
        echo "Installing SML/NJ..."
        (brew install smlnj) || echo "Brew/SML-NJ installation failed"
    else
        echo "Skipping SML/NJ..."
    fi

    #install nethack
    read -n 1 -p "Install nethack via Brew [Y/n]? " installNethack && echo
    if [[ $installNethack =~ ^(y|Y) ]]; then
        echo "Installing nethack..."
        (brew install nethack) || echo "Brew/nethack installation failed"
    else
        echo "Skipping nethack..."
    fi

    #install python
    read -n 1 -p "Install python via Brew [Y/n]? " installPython && echo
    if [[ $installPython =~ ^(y|Y) ]]; then
        echo "Installing Python..."
        (brew install python) || echo "Brew/python installation failed"
    else
        echo "Skipping python..."
    fi

    #install python3
    read -n 1 -p "Install python3 via Brew [Y/n]? " installPython3 && echo
    if [[ $installPython3 =~ ^(y|Y) ]]; then
        echo "Installing python3..."
        (brew install python3) || echo "Brew/python3 installation failed"
    else
        echo "Skipping python3..."
    fi

    #install tree
    read -n 1 -p "Install tree via Brew [Y/n]? " installTree && echo
    if [[ $installTree =~ ^(y|Y) ]]; then
        echo "Installing tree..."
        (brew install tree) || echo "Brew/tree installation failed"
    else
        echo "Skipping tree..."
    fi
else
    echo "Skipping Brew..."
fi
echo
