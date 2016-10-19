#reload profile
alias reload='source ~/.bash_profile'

#set default editor to vim
export EDITOR=vim

#aliases
alias quit='exit'                           # Because Mac OS X tends to call it quit
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias hidden='ls -a | grep "^\."'           # List all hidden files
cd() { builtin cd "$@"; ls; }               # Always list files on cd

#functions


