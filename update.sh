#!/bin/bash
# updates Dotfiles

(cd ~/Dotfiles && git checkout master && git pull origin master) > /dev/null 2>&1 && echo "Updated" || echo "Update failed"
echo "Type 'reload' to reload updates"
