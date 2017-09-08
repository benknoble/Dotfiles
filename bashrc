# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return ;;
esac

# VARS

# dir for brew scripts
brewscripts="$HOME/Dotfiles/brew"

# set default editor to vim
export EDITOR=vim

# use my color scheme for ls
export LSCOLORS="gxfxcxdxbxegedabagacad"

# Message of the Day control
# COW controls which cow to use (use `cowsay -l` or `cowvis` for options)
# COLOR controls whether or not to use lolcat for color (0=yes, 1+=no)
COW=small
COLOR=0

# set PS2
# PS2="λ "
PS2="» "
# set PS3
PS3="$PS2"

# reload profile
alias reload='. ~/.bashrc >/dev/null && echo "reloaded"'

# load colors
source ~/Dotfiles/bash/colors.bash

# load aliases
source ~/Dotfiles/bash/aliases.bash

# load functions
source ~/Dotfiles/bash/functions.bash

# load git config
source ~/Dotfiles/bash/gitconfig.bash

# set PS1
# __gps1 is a special value exported by gitconfig above
# it is basically a bash command that returns the branch name for PS1 formatting
# PS1="$CS$BRed$CE\jj$CS$NC$CE $CS$BMagenta$CE#\!$CS$NC$CE $CS$BWhite$CE\u$CS$NC$CE:$CS$BCyan$CE\W$CS$NC$CE $CS$BYellow$CE\$("$__gps1")$CS$NC$CE"'\$ '
source ~/Dotfiles/bash/PS1.bash

# use nullglob (if glob doesn't expand into anything, it is not preserved as literal text)
shopt -s nullglob

# don't accidentally overwrite files with '>' (use '>|' to force overwriting)
set -o noclobber

# let 'space' magically expand history command-line fu
# use M-C-e to expand *all* command-line fu
bind Space:magic-space

HISTSIZE=100000
HISTFILESIZE="$HISTSIZE"
shopt -s histappend

# Add bin folder for scripts to path
pathadd "$HOME/Dotfiles/bin"

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
# and brew cask
caskcomp=/usr/local/etc/bash_completion.d/brew-cask
[[ -s "$caskcomp" ]] && source "$caskcomp"

# scala completion is possible
scalacomp=/usr/local/Cellar/scala/2.12.3/etc/bash_completion.d/scala
[[ -s "$scalacomp" ]] && source "$scalacomp"

# add brew ext commands to path
pathadd "$brewscripts/ext"

# Message of the Day
# COW controls which cow to use (use `cowsay -l` or `cowvis` for options)
# COLOR controls whether or not to use lolcat for color (0=yes, 1+=no)
if [[ -x "$(which cowsay)" && -x "$(which fortune)" ]]; then
    message="$(fortune -a)"
    if [[ -z "$COW" ]]; then
        COW=default
    fi
    message="$(echo "$message" | cowsay -f "$COW" -n)"
    if [[ -x "$(which lolcat)" && "$COLOR" = "0" ]]; then
        lolcat <<<"$message"
    else
        echo "$message"
    fi
fi
