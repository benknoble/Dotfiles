#reload profile
alias reload='. ~/.bash_profile && echo "reloaded"'

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

#set default editor to vim
export EDITOR=vim

#use my color scheme for ls
export LSCOLORS="gxfxcxdxbxegedabagacad"

#use nullglob (if glob doesn't expand into anything, it is not preserved as literal text)
shopt -s nullglob

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

# dir for brew scripts
export brewscripts="$HOME/Dotfiles/brew"
