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

# Add bin folder for scripts to path
pathadd "$HOME/.bin"

if "$has_brew" ; then
  pathadd_front "$brew_prefix/bin"
  brew_fix() {
    local type="$1"
    local path="${!type}"
    local prepend="$2"
    case "$path" in
      "$prepend"* ) true ;;
      * ) eval export "$type=$prepend:$path" ;;
    esac
  }
  # first clear manpath on macs
  case "$OS" in
    mac ) export MANPATH=
  esac
  brew_fix MANPATH "$brew_prefix/share/man"
  brew_fix INFOPATH "$brew_prefix/share/info"
fi

# go
[[ -d ~/go/bin ]] && pathadd ~/go/bin

# git
git="$(command -v git)"
prefix=${git//bin*/}
contrib=${prefix}/share/git-core/contrib
gitjump=${contrib}/git-jump
if [[ -d "$gitjump" ]] && [[ -x "$gitjump"/git-jump ]]; then
  pathadd "$gitjump"
fi

unset git
unset prefix
unset contrib
unset gitjump
