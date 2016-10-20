#reload profile
alias reload='. ~/.bash_profile && echo "reloaded"'

#set default editor to vim
export EDITOR=vim

#aliases
alias quit='exit'                           # Because Mac OS X tends to call it quit
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias rm='rm -i'                            # Preferred 'rm' implementation
alias hidden='ls -a | grep "^\."'           # List all hidden files

#functions
cdls() { cd "$@" && ls; }

