#!/bin/bash
# updates Dotfiles

(cd ~/Dotfiles && git pull origin master && reload) && echo "Updated" || echo "Update failed"
