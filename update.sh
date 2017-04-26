#! /bin/bash -
# updates Dotfiles

(cd ~/Dotfiles && git checkout master && git pull origin master) > /dev/null 2>&1 && echo "Updated" || echo "Update failed"
echo "Type 'reload' to reload updates"
echo "You may need to logout of the terminal and login for changes to take full effect"
