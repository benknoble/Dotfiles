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

if [[ -z "$PS1" ]]; then
    export $PS1="\! \u:\W \$ "
fi

#use nullglob (if glob doesn't expand into anything, it is not preserved as literal text)
shopt -s nullglob

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
