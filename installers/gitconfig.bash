#! /bin/bash
# git config done on install

[[ -s ~/.gitconfig ]] && {
backup=~/Dotfiles_old/gitconfig;
echo "Backing up old gitconfig file to $backup";
mv ~/.gitconfig "$backup";
}

echo
echo "Configuring git..."
echo

#some useful git aliases
git config --global --replace-all alias.cd checkout
git config --global --replace-all alias.stat status
git config --global --replace-all alias.ls branch
git config --global --replace-all alias.cc commit
git config --global --replace-all alias.cm 'commit -m'
git config --global --replace-all merge.tool vimdiff
git config --global --replace-all merge.conflictstyle diff3
git config --global --replace-all color.ui true
git config --global --replace-all core.autocrlf input

gitignoreglobal=~/.gitignore_global

echo "[Will overwrite current file if it exists]"
echo "[If file does not exist, it will be created]"
read -n 1 -p "Create coreexcludes file at $gitignoreglobal [Y/n]? " core && echo
if [[ $core =~ ^(y|Y) || !( -s "$gitignoreglobal" ) ]]; then
    cat >"$gitignoreglobal" <<'END'
# no backups
*.~
.*.swp

# no macOS pesky files
.DS_Store
END
    echo "coreexcludes file created"
fi

#global gitignore
if [[ -s "$gitignoreglobal" ]]; then
    git config --global --replace-all core.excludesfile "$gitignoreglobal"
fi
