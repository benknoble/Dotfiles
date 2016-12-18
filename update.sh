#!/bin/bash
# updates Dotfiles

(cd ~/Dotfiles && git checkout master && git pull origin master) && echo "Updated" || echo "Update failed"
