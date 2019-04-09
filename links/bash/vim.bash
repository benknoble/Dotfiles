#! /usr/bin/env bash

v_funcs() {
  $PAGER ~/.bash/vim.bash
}

v() {
  vim "$@"
}

vv() {
  vim +'edit $MYVIMRC' "$@"
}

vq() {
  if (($# > 0)); then
    vim -q <("$@" 2>&1)
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
    # equivalent to vf ack -g "$1"
    vim $(ack -g "$1")
  else
    printf '%s\n' 'Usage: vff filename' '' 'Find {filename} to edit' \
      'Relies on ack(1)'
  fi
}

vc() {
  if (($# > 0)); then
    ( cd "$1" && shift && vim "$@" )
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
