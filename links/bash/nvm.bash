use_nvm() {
  export NVM_DIR=~/.nvm
  if ! [[ -d "$NVM_DIR" ]] ; then mkdir "$NVM_DIR" ; fi
  if [[ -z "$NVM_PATH" ]] ; then
    NVM_PATH=/usr/local/opt/nvm/nvm.sh
  fi
  if [[ -s "$NVM_PATH" ]] ; then
    . "$NVM_PATH"
  fi
  if [[ -s /usr/local/etc/bash_completion.d/nvm ]]; then
    . /usr/local/etc/bash_completion.d/nvm
  fi
}

if [[ -s ./.nvmrc ]] ; then
  use_nvm
fi
