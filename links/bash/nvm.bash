if command -v brew >/dev/null 2>&1; then
  use_nvm() {
    local brew_prefix
    brew_prefix="$(cat ~/.brew-prefix 2>/dev/null || brew --prefix | tee ~/.brew-prefix)"
    export NVM_DIR=~/.nvm
    if ! [[ -d "$NVM_DIR" ]] ; then mkdir "$NVM_DIR" ; fi
    if [[ -z "$NVM_PATH" ]] ; then
      NVM_PATH="$brew_prefix"/opt/nvm/nvm.sh
    fi
    if [[ -s "$NVM_PATH" ]] ; then
      . "$NVM_PATH"
    fi
    if [[ -s "$brew_prefix"/etc/bash_completion.d/nvm ]]; then
      . "$brew_prefix"/etc/bash_completion.d/nvm
    fi
  }
else
  use_nvm() {
    export NVM_DIR="${XDG_CONFIG_HOME:-$HOME}/.nvm"
    [[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"
    [[ -s "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"
  }
fi

if [[ -s ./.nvmrc ]] ; then
  use_nvm
fi
