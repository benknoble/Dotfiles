#!/bin/bash
# updates Dotfiles

(cd ~/Dotfiles && git pull origin master) && echo "Updated" || echo "Update failed"
