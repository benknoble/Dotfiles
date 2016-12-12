#reload profile
alias reload='. ~/.bash_profile && echo "reloaded"'

########################################
#         COLOR DEFINITIONS            #
########################################

export NC='\[\033[0m\]'

export BLACK='\[\033[0;30m\]'
export RED='\[\033[0;31m\]'
export GREEN='\[\033[0;32m\]'
export YELLOW='\[\033[0;33m\]'
export BLUE='\[\033[0;34m\]'
export PURPLE='\[\033[0;35m\]'
export CYAN='\[\033[0;36m\]'
export WHITE='\[\033[0;37m\]'

#bold
export BBLACK='\[\033[0;90m\]'
export BRED='\[\033[0;91m\]'
export BGREEN='\[\033[0;92m\]'
export BYELLOW='\[\033[0;93m\]'
export BBLUE='\[\033[0;94m\]'
export BPURPLE='\[\033[0;95m\]'
export BCYAN='\[\033[0;96m\]'
export BWHITE='\[\033[0;97m\]'

#background
export ON_BLACK='\[\033[0;40m\]'
export ON_RED='\[\033[0;41m\]'
export ON_GREEN='\[\033[0;42m\]'
export ON_YELLOW='\[\033[0;43m\]'
export ON_BLUE='\[\033[0;44m\]'
export ON_PURPLE='\[\033[0;45m\]'
export ON_CYAN='\[\033[0;46m\]'
export ON_WHITE='\[\033[0;47m\]'

#bold background
export ON_BBLACK='\[\033[0;100m\]'
export ON_BRED='\[\033[0;101m\]'
export ON_BGREEN='\[\033[0;102m\]'
export ON_BYELLOW='\[\033[0;103m\]'
export ON_BBLUE='\[\033[0;104m\]'
export ON_BPURPLE='\[\033[0;105m\]'
export ON_BCYAN='\[\033[0;106m\]'
export ON_BWHITE='\[\033[0;107m\]'

#add git branch to prompt when available and colorize
export PS1="$BPURPLE\!$NC $BWHITE\u$NC:$BCYAN\W$NC $BYELLOW\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)$NC\$ "

#add git autocompletion, if it exists
[[ -e ~/.git-completion.bash ]] && . ~/.git-completion.bash

#set default editor to vim
export EDITOR=vim

#use my color scheme for ls
export LSCOLORS="gxfxcxdxbxegedabagacad"

#use nullglob (if glob doesn't expand into anything, it is not preserved as literal text)
shopt -s nullglob

#aliases
alias quit='exit'                           # Because Mac OS X tends to call it quit
alias ls='ls -aGF'                          # Preferred 'ls' implementation
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias rm='rm -i'                            # Preferred 'rm' implementation
alias hidden='ls -a | grep "^\."'           # List all hidden files
alias cd..='cd ../'                         # Go back one directory level
alias ..='cd ../'                           # Shorter version of cd..
alias ~='cd'                                # Shortcut to cd ~
alias edit='vim'                            # Open a file in vim
alias readonly='vim -R'                     # Open a file in readonly mode in vim
alias explore='vim +Explore'                # Open vim's Explore mode in current directory
alias finder='open -a Finder ./'            # Open current directory in Finder
alias gitpretty='gitk'                      # pretty git display using wish
alias app='open -a'                         # Open an application

#functions
cdls() { cd "$@" && ls ; }                  # cd and ls
trash() { mv "$@" ~/.Trash ; }              # Move a file to Trash
aliases() { cat ~/.bash_profile | grep -o --color=auto "^alias [\.A-Za-z0-9~]*" ; } # List all aliases found in this file
functions() { cat ~/.bash_profile | grep -o --color=auto "^[A-Za-z0-9]*()" ; }      # List all functions found in this file
findPid() { lsof -t -c "$@" ; }             # Find Pid of specified process
displayPath() { for path in ${PATH//:/ }; do echo "$path"; done; }                  # Print path separated by newlines
mkcd() { mkdir "$@" && cd "$@" ; }          # mkdir and cd
editall() { vim -p "$@" ; }                 # edit all files provided as arguments in vim tabs

# Setting PATH for Python 3.5
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
export PATH

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Setting PATH for Python 2.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

# Set PATH for scala
export PATH="/Users/Knoble/scala-2.11.8/bin:${PATH}"

# Add bin folder for scripts to path
export PATH="$HOME/bin:${PATH}"
