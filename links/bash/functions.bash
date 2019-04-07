#! /usr/bin/env bash
# function definitions

cdls () { cd "$@" && ls ; }                  # cd and ls
aliases () { tail -n +4 ~/.bash/aliases.bash | less ; }                 # List all aliases found in this file
functions () { tail -n +4 ~/.bash/functions.bash | less ; }             # List all functions found in this file
findPid () { lsof -t -c "$@" ; }             # Find Pid of specified process
displayPath () { echo "${PATH//:/$'\n'}" ; } # Print path separated by newlines
mkcd () { mkdir "$@" && cd "$@" ; }          # mkdir and cd
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

pathadd_front() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="$1:$PATH"
  fi
}

freewrite() {
  local date="$(date -j +"%e-%B-%Y" | tr -d '[:space:]' | tr '-' ' ')"
  local file="$(date -j +"%e-%B-%Y" | tr -d '[:space:]')".md
  echo -e "Free-write $date\n\n" > "$file"
  vim +3 "$file"
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
  if (( $# < 1 )); then
    echo "Missing argument" >&2
    return 1
  fi

  for f in "$@"; do
    mkdir -p -- "$(dirname -- "$f")"
    touch -- "$f"
  done
}

# report frequency of items on stdin
frequency() {
  sort | uniq -c | sort -g
}

# most-often used commands, sorted by frequency
recent() {
  history | cut -c8- | cut -d" " -f1 | frequency | sort -rn | head
}

# go up
up() {
  local count="${1:-1}"
  local path=../
  (( count-- ))
  while (( count > 0 )) ; do
    path="$path"../
    (( count-- ))
  done
  echo "cd -- $path"
  cd -- "$path"
}

ed() {
  command ed -p: "$@"
}

G() {
  grep --color=auto "$@"
}

EG() {
  grep -E --color=auto "$@"
}

L() {
  less "$@"
}

# heroku completion
complete_heroku() {
  command -v heroku &> /dev/null \
    && eval "$(heroku autocomplete:script bash)"
}

# travis completion
complete_travis() {
  command -v travis &> /dev/null \
    && [[ -f ~/.travis/travis.sh ]] \
    && source ~/.travis/travis.sh
}

markdownify() {
  # reads from stdin
  command=(
    curl
    --silent
    https://api.github.com/markdown/raw
    -X "POST"
    -H "Content-Type: text/x-markdown"
    --data-binary @-
  )
  "${command[@]}"
}
