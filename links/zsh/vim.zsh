v_funcs() {
  $PAGER ~/.zsh/vim.zsh
}

v() {
  vim "$@"
}

vv() {
  vim +'edit $MYVIMRC' "$@"
}

vq() {
  if (($# > 0)); then
    vim -q =("$@" 2>&1)
  else
    printf '%s\n' 'Usage: vq cmd' '' 'Use {cmd} output as quickfix list'
  fi
}

vf() {
  if (($# > 0)); then
    vim $("$@")
  else
    printf '%s\n' 'Usage: vf cmd' '' 'Use {cmd} output as filenames' \
      'Brittle: {cmd} output will be word-split'
  fi
}

vff() {
  if (($# == 1)) ; then
    vim $(rg --files | grep "$1")
  else
    printf '%s\n' 'Usage: vff filename' '' 'Find {filename} to edit' \
      'Relies on rg(1)'
  fi
}

vc() {
  if (($# > 0)); then
    if pushd "$1" >/dev/null ; then
      # ${@[0]} = $0 = name
      # ${@[1]} = $1 = directory
      # ${@:2}  = remaining args
      vim "${@:2}"
      # this must work because pushd succeeded
      popd >/dev/null
    fi
  else
    printf '%s\n' 'Usage: vc dir [args]' '' 'Execute vim in {dir}'
  fi
}

vs() {
  if (($# > 0)); then
    local session="$1"
    shift
    vim "$@" -S "$session"
  else
    vim -S
  fi
}

# Start vim with its last cursor position
lvim() {
  vim +'normal '"'"'0' "$@"
}

vh() {
  vim +"help $*" +only
}

vgrep() {
  local pattern="${1////\\/}"
  for f in "${@:2}" ; do
    if [[ -f "$f" ]]; then
      ex -N -i NONE -n -- "$f" <<<"argdo global/$pattern/print" \
        | sed "s/^/${f////\\/}:/"
    # else
    #   printf '%s\n' "${FUNCNAME[0]}: $f: Is a directory" >&2
    fi
  done
}

vw() {
  { vim ="$*" } always {
    if (( TRY_BLOCK_ERROR == 1 )) ; then
    printf '%s\n' 'Usage: vw cmd' '' 'edit file defining {cmd}'
    fi
  }
}

vn() {
  vim +'Ewiki notepad' "$@"
}
