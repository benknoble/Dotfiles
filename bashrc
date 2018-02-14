# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return ;;
esac

# VARS

# dir for brew scripts
brewscripts="$HOME/Dotfiles/brew/ext"

# dir for git scripts
gitscripts="$HOME/Dotfiles/git/ext"

# set default editor to vim
export VISUAL="$(command -v vim)"
export EDITOR="$VISUAL"

# use my color scheme for ls
export LSCOLORS="gxfxcxdxbxegedabagacad"

# use less on any system
export PAGER="less -R"

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

# file to hold private keys
private=~/.private
# completion paths
bashcomp=/usr/local/share/bash-completion/bash_completion
completion_dir=/usr/local/etc/bash_completion.d

# use nullglob (if glob doesn't expand into anything, it is not preserved as literal text)
shopt -s nullglob

# don't accidentally overwrite files with '>' (use '>|' to force overwriting)
set -o noclobber

# let 'space' magically expand history command-line fu
# use M-C-e to expand *all* command-line fu
bind "SPACE: magic-space"

# use vi readline bindings
set -o vi

HISTSIZE=100000
HISTFILESIZE="$HISTSIZE"
shopt -s histappend

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

# source .private for meant to never be seen
[[ -r "$private" ]] && source "$private"

# source anything in ~/.personal
if [[ -d ~/.personal ]]; then
  for file in ~/.personal/*.sh; do
    if [[ -r "$file" ]]; then
      source "$file"
    fi
  done
  unset file
  # add ~/.personal/bin to path
  if [[ -d ~/.personal/bin ]]; then
    pathadd "$HOME/.personal/bin"
  fi
fi

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

# bash completion
[[ -r "$bashcomp" ]] && source "$bashcomp"
# source files in completion_dir
for file in "$completion_dir"/*; do
  if [[ -r "$file" ]]; then
    source "$file"
  fi
done

# add brew ext commands to path
pathadd "$brewscripts"

# add git ext commands to path
pathadd "$gitscripts"

# Handle commands not found
if [[ "$(type -t command_not_found_handle)" != function ]]; then
  command_not_found_handle() {
    {
      echo -e "$BRed"Command not found: "$NC$BYellow$1$NC"
      shift
      if [[ $# -gt 0 ]]; then
        echo "$#" args: "$(join_by ', ' "${@@Q}")"
      fi
      echo -e Try "$BGreen"'`displayPath`'"$NC" to see the path
    } >&2
    return 127
  }
fi

# disable flow control
stty -ixon -ixoff

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
