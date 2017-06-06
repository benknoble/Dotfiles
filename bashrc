# VARS

# dir for brew scripts
export brewscripts="$HOME/Dotfiles/brew"

# set default editor to vim
export EDITOR=vim

# use my color scheme for ls
export LSCOLORS="gxfxcxdxbxegedabagacad"

# Message of the Day control
# COW controls which cow to use (use `cowsay -l` for options)
# COLOR controls whether or not to use lolcat for color (0=yes, 1+=no)
export COW=small
export COLOR=1

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
export PS1="$CS$BRED$CE\jj$NC $CS$BPURPLE$CE#\!$NC $CS$BWHITE$CE\u$NC:$CS$BCYAN$CE\W$NC $CS$BYELLOW$CE\$("$__gps1")$NC"'\$ '

# use nullglob (if glob doesn't expand into anything, it is not preserved as literal text)
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

# add brew ext commands to path
pathadd "$brewscripts/ext"

# Message of the Day
# COW controls which cow to use (use `cowsay -l` for options)
# COLOR controls whether or not to use lolcat for color (0=yes, 1+=no)
if [[ $(which -s cowsay) -eq 0 && $(which -s fortune) -eq 0 ]]; then
    message="$(fortune -a)"
    if [[ -z "$COW" ]]; then
        COW=default
    fi
    message="$(echo "$message" | cowsay -f "$COW" -n)"
    if [[ $(which -s lolcat) -eq 0 && "$COLOR" = "0" ]]; then
        lolcat <<<"$message"
    else
        echo "$message"
    fi
fi
