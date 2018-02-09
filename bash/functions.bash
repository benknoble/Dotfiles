#! /usr/bin/env bash
# function definitions

cdls () { cd "$@" && ls ; }                  # cd and ls
trash () { mv "$@" ~/.Trash ; }              # Move a file to Trash
aliases () { cat ~/Dotfiles/bash/aliases.bash | tail -n +4 | less ; }                 # List all aliases found in this file
functions () { cat ~/Dotfiles/bash/functions.bash | tail -n +4 | less ; }             # List all functions found in this file
findPid () { lsof -t -c "$@" ; }             # Find Pid of specified process
displayPath () { echo "${PATH//:/$'\n'}" ; } # Print path separated by newlines
mkcd () { mkdir "$@" && cd "$@" ; }          # mkdir and cd
editall () { vim -p "$@" ; }                 # edit all files provided as arguments in vim tabs
extract () {                                 # attempt to extract file with correct extraction method
  for file in "$@"; do
    if [ -f "$file" ]; then
      case "$file" in
        *.tar.bz2)  tar xjf "$file"      ;;
        *.tar.gz)   tar xzf "$file"      ;;
        *.bz2)      bunzip2 "$file"      ;;
        *.rar)      unrar x "$file"      ;;
        *.gz)       gunzip "$file"       ;;
        *.tar)      tar xf "$file"       ;;
        *.tbz2)     tar xjf "$file"      ;;
        *.tgz)      tar xzf "$file"      ;;
        *.zip)      unzip "$file"        ;;
        *.Z)        uncompress "$file"   ;;
        *)          echo "'$file' cannot be extracted via extract()" ;;
      esac
    else
      echo "'$file' is not a valid file"
    fi
  done
}

pathadd() {                                 # add to path
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="${PATH:+"$PATH:"}$1"
  fi
}

freewrite() {
  local date="$(date -j +"%e-%B-%Y" | tr -d '[:space:]' | tr '-' ' ')"
  local file="$(date -j +"%e-%B-%Y" | tr -d '[:space:]')".md
  echo -e "Free-write $date\n\n" > "$file"
  vim +3 "$file"
}

getip() {
  ipconfig getifaddr en0
}

quote() {
  printf %s\\n "$1" | sed "s/'/'\\\\''/g;1s/^/'/;\$s/\$/'/"
}

# joinby delim args
join_by() {
  local d=$1
  shift
  echo -n "$1"
  shift
  printf "%s" "${@/#/$d}"
  echo
}

# mktouch path/to/file ...
mktouch() {
  if [ $# -lt 1 ]; then 
    echo "Missing argument" >&2
    return 1
  fi

  for f in "$@"; do
    mkdir -p -- "$(dirname -- "$f")"
    touch -- "$f"
  done
}
