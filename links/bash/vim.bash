#! /usr/bin/env bash

v_funcs() {
  $PAGER ~/.bash/vim.bash
}

v() {
  vim "$@"
}

complete -F _filedir_xspec v

vv() {
  vim +'edit $MYVIMRC' "$@"
}

complete -F _filedir_xspec vv

vq() {
  if (($# > 0)); then
    vim -q <("$@" 2>&1)
  else
    printf '%s\n' 'Usage: vq cmd' '' 'Use {cmd} output as quickfix list'
  fi
}

complete -A command vq

vf() {
  if (($# > 0)); then
    vim $("$@")
  else
    printf '%s\n' 'Usage: vf cmd' '' 'Use {cmd} output as filenames' \
      'Brittle: {cmd} output will be word-split'
  fi
}

complete -A command vf

vff() {
  if (($# == 1)) ; then
    # equivalent to vf ack -g "$1"
    vim $(ack -g "$1")
  else
    printf '%s\n' 'Usage: vff filename' '' 'Find {filename} to edit' \
      'Relies on ack(1)'
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

complete -A directory vc

vs() {
  if (($# > 0)); then
    local session="$1"
    shift
    vim "$@" -S "$session"
  else
    vim -S
  fi
}

complete -G '*.vim' vs

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
  if [[ "$(type -t "$@")" != file ]]; then
    printf '%s\n' 'Usage: vw cmd' '' 'edit file defining {cmd}'
  else
    vim "$(command -v "$@")"
  fi
}

complete -A command vw
