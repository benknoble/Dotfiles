#!/bin/bash
# updates Dotfiles

(cd ~/Dotfiles && git pull) && echo "Updated" || echo "Update failed"
