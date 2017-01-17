#reload profile
alias reload='. ~/.bash_profile && echo "reloaded"'

#load colors
source ~/Dotfiles/colors.bash

#load aliases
source ~/Dotfiles/aliases.bash

#add git branch to prompt when available and colorize
if [[ -s ~/.git-prompt.sh ]]; then
	. ~/.git-prompt.sh
	export GIT_PS1_SHOWDIRTYSTATE='true'
	export GIT_PS1_SHOWSTASHSTATE='true'
	export GIT_PS1_SHOWUNTRACKEDFILES='true'
	export GIT_PS1_SHOWUPSTREAM='auto'
	export GIT_PS1_STATESEPARATOR=' '
	export PS1="$CS$BPURPLE$CE\!$CS$NC$CE $CS$BWHITE$CE\u$CS$NC$CE:$CS$BCYAN$CE\W$CS$NC$CE $CS$BYELLOW$CE\$(__git_ps1 '%s ')$CS$NC$CE\$ "
else
	export PS1="$CS$BPURPLE$CE\!$CS$NC$CE $CS$BWHITE$CE\u$CS$NC$CE:$CS$BCYAN$CE\W$CS$NC$CE $CS$BYELLOW$CE\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)$CS$NC$CE\$ "
fi

#add git autocompletion, if it exists
[[ -s ~/.git-completion.bash ]] && . ~/.git-completion.bash

#some useful git aliases
git config --global --replace-all alias.cd checkout
git config --global --replace-all alias.stat status
git config --global --replace-all alias.ls branch
git config --global --replace-all merge.tool vimdiff
git config --global --replace-all merge.conflictstyle diff3
git config --global --replace-all color.ui true

#set default editor to vim
export EDITOR=vim

#use my color scheme for ls
export LSCOLORS="gxfxcxdxbxegedabagacad"

#use nullglob (if glob doesn't expand into anything, it is not preserved as literal text)
shopt -s nullglob

#functions
cdls () { cd "$@" && ls ; }                  # cd and ls
trash () { mv "$@" ~/.Trash ; }              # Move a file to Trash
aliases () { cat ~/Dotfiles/aliases.bash | tail -n +4 ; }                             # List all aliases found in this file
functions () { cat ~/.bash_profile | grep -o --color=auto "^[A-Za-z0-9]* ()" ; }      # List all functions found in this file
findPid () { lsof -t -c "$@" ; }             # Find Pid of specified process
displayPath () { for path in ${PATH//:/ }; do echo "$path"; done; }                  # Print path separated by newlines
mkcd () { mkdir "$@" && cd "$@" ; }          # mkdir and cd
editall () { vim -p "$@" ; }                 # edit all files provided as arguments in vim tabs
extract () {                                 # attempt to extract file with correct extraction method
	if [ -f $1 ]; then
		case $1 in
			*.tar.bz2)	tar xjf $1		;;
			*.tar.gz)	tar xzf $1		;;
			*.bz2)		bunzip2 $1		;;
			*.rar)		rar x $1		;;
			*.gz)		gunzip $1		;;
			*.tar)		tar xf $1		;;
			*.tbz2)		tar xjf $1		;;
			*.tgz)		tar xzf $1		;;
			*.zip)		unzip $1		;;
			*.Z)		uncompress $1	;;
			*)			echo "'$1' cannot be extracted via extract()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

pathadd() {                                 # add to path
	if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
		PATH="${PATH:+"$PATH:"}$1"
	fi
}

# Setting PATH for Python 3.5
# The original version is saved in .bash_profile.pysave
pathadd "/Library/Frameworks/Python.framework/Versions/3.5/bin"

# Setting PATH for Python 2.7
# The original version is saved in .bash_profile.pysave
pathadd "/Library/Frameworks/Python.framework/Versions/2.7/bin"

# Set PATH for scala
pathadd "/Users/Knoble/scala-2.11.8/bin"

# Add bin folder for scripts to path
pathadd "$HOME/bin"
