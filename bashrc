# VARS

# dir for brew scripts
export brewscripts="$HOME/Dotfiles/brew"

#set default editor to vim
export EDITOR=vim

#use my color scheme for ls
export LSCOLORS="gxfxcxdxbxegedabagacad"

#reload profile
alias reload='. ~/.bashrc && echo "reloaded"'

#load colors
source ~/Dotfiles/bash/colors.bash

#load aliases
source ~/Dotfiles/bash/aliases.bash

#load functions
source ~/Dotfiles/bash/functions.bash

#load git config
source ~/Dotfiles/bash/gitconfig.bash

#set PS1
#__gps1 is a special value exported by gitconfig above
#it is basically a bash command that returns the branch name for PS1 formatting
export PS1="$CS$BRED$CE\j$CS$NC$CE $CS$BPURPLE$CE\!$CS$NC$CE $CS$BWHITE$CE\u$CS$NC$CE:$CS$BCYAN$CE\W$CS$NC$CE $CS$BYELLOW$CE\$("$__gps1")$CS$NC$CE"'\$ '

#use nullglob (if glob doesn't expand into anything, it is not preserved as literal text)
shopt -s nullglob

HISTSIZE=100000
HISTFILESIZE="$HISTSIZE"
shopt -s histappend

# Set PATH for scala
pathadd "/Users/Knoble/scala-2.11.8/bin"

# Add bin folder for scripts to path
pathadd "$HOME/bin"

# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end

# brew completion if possible
brewcomp=/usr/local/etc/bash_completion.d/brew
[[ -s "$brewcomp" ]] && source "$brewcomp"
