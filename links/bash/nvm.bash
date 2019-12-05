export NVM_DIR=~/.nvm
if ! [[ -d "$NVM_DIR" ]] ; then mkdir "$NVM_DIR" ; fi
if [[ -z "$NVM_PATH" ]] ; then
  NVM_PATH=/usr/local/opt/nvm/nvm.sh
fi
if [[ -s "$NVM_PATH" ]] ; then
  . "$NVM_PATH"
fi
