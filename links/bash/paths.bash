# Print path separated by newlines
displayPath () { echo "${PATH//:/$'\n'}" ; }

# add to path
pathadd() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="${PATH:+"$PATH:"}$1"
  fi
}

pathadd_front() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="$1:$PATH"
  fi
}

if command -v python3 >/dev/null 2>&1 ; then
  python_path="$(python3 -m site --user-base)/bin"
  pathadd "$python_path"
fi
