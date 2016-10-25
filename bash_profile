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
alias cd..='cd ../'                         # Go back one directory level
alias ..='cd ../'                           # Shorter version of cd..
alias edit='vim'                            # Open a file in vim
alias readonly='vim -R'                         # Open a file in readonly mode in vim
alias explore='vim +Explore'                # Open vim's Explore mode in current directory
alias finder='open -a Finder ./'            # Open current directory in Finder
alias path='echo "$PATH"'                   # Show path
alias epath='vim /etc/paths'                # Edit paths

#functions
cdls() { cd "$@" && ls ; }                  # cd and ls
trash() { mv "$@" ~/.Trash ; }              # Move a file to Trash
aliases() { cat ~/.bash_profile | grep -o --color=auto "^alias [\.A-Za-z0-9]*" ; } # List all aliases found in this file
functions() { cat ~/.bash_profile | grep -o --color=auto "[A-Za-z0-9]*()" ; }      # List all functions found in this file
findPid() { lsof -t -c "$@" ; }             # Find Pid of specified process


# Setting PATH for Python 3.5
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
export PATH
