# Print path separated by newlines
pathprint () {
  if (($# == 0)); then
    set -- PATH
  fi
  for path; do
    if [[ "$path" != PATH ]]; then
      path+=PATH
    fi
    echo "$path"
    echo "${!path//:/$'\n'}"
  done
}

_pathdebug() {
  if [[ -n "$pathdebug" ]]; then
    # find the file which is our caller's caller
    local source="${BASH_SOURCE[2]}"
    if [[ -z "$source" ]]; then
      # we were called from interactive
      source=interactive
    fi
    printf 'PATH DEBUG:\t%s\t(%s)\n' "$source" "$1" >&2
  fi
}

# add to path
pathadd() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="${PATH:+"$PATH:"}$1"
    _pathdebug "$1"
  fi
}

pathadd_front() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="$1:$PATH"
    _pathdebug "$1"
  fi
}

pathrm() {
  if [[ ":$PATH:" = *":$1:"* ]]; then
    PATH="${PATH//${1//\//\\\/}/}"
    PATH="${PATH%:}"
    PATH="${PATH#:}"
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
      * )
        eval export "$type=$prepend:$path"
        if [[ "$type" = PATH ]]; then
          _pathdebug "$prepend"
        fi
        ;;
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
pathadd ~/go/bin

# git
git="$(command -v git)"
prefix=${git//bin*/}
contrib=${prefix}/share/git-core/contrib
gitjump=${contrib}/git-jump
if [[ -x "$gitjump"/git-jump ]]; then
  pathadd "$gitjump"
fi

unset git
unset prefix
unset contrib
unset gitjump

pathadd_front_dne() {
  if [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="$1:$PATH"
    _pathdebug "$1"
  fi
}
pathadd_front_dne ".git/safe/../../bin"

local_perl_bin=~/perl5/bin
pathadd "$local_perl_bin"
if [[ -d "$local_perl_bin" ]]; then
  PERL5LIB="/Users/Knoble/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
  export PERL5LIB
  PERL_LOCAL_LIB_ROOT="/Users/Knoble/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
  export PERL_LOCAL_LIB_ROOT
  PERL_MB_OPT='--install_base /Users/Knoble/perl5'
  export PERL_MB_OPT
  PERL_MM_OPT="INSTALL_BASE=/Users/Knoble/perl5"
  export PERL_MM_OPT
fi
unset local_perl_bin
