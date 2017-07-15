#! /bin/bash -
# git setup

# config function
# Args: 1:section 2:key
# Usage: config user name
# -- Prompts for user name and then does git config --global user.name $input
config() {
    read -p "Enter git $1 $2 > " u_in
    git config --global "$1.$2" "$u_in"
    echo "git $1 $2 = $u_in"
}

echo "Configuring git..."
echo

# reconfigure user name, email address
echo "Configure user name and email..."
name="$(git config --global --get user.name)"
email="$(git config --global --get user.email)"

if [[ -z "$name" ]]; then
    echo "No previous user name"
    config user name
else
    echo "Previous user name: $name"
    read -n 1 -p "Is [name = $name] ok [Y/n] ? " nameok && echo
    if [[ !("$nameok" =~ ^(y|Y)) ]]; then
        config user name
    fi
fi
echo

if [[ -z "$email" ]]; then
    echo "No previous user email"
    config user email
else
    echo "Previous user email: $email"
    read -n 1 -p "Is [email = $email] ok [Y/n] ? " emailok && echo
    if [[ !("$emailok" =~ ^(y|Y)) ]]; then
        config user email
    fi
fi
echo

echo "...done with user info"
echo

echo "Configure global gitignore..."
# replace with the name of your global gitignore file if you've changed it
globalignore="~/.gitignore_global"
git config --global --replace-all core.excludesfile "$globalignore"
echo "...done with global gitignore"
echo

echo "...done configuring git"
