#! /usr/bin/env bash -
# an install script to install custom stuff
# executes all scripts in ./installers/, which makes it prone to attack if not careful.
# however, it also allows you to add your own installer scripts

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$(dirname "$DIR")/dotfiles-support"

execute_installers() {
  find "$DIR"/installers -maxdepth 1 -type f -name "*.sh" -ok sh {} \;
}

execute_installers
