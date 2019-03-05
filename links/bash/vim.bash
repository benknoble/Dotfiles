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

vc() {
  if (($# > 0)); then
    ( cd "$1" && shift && vim "$@" )
  else
    printf '%s\n' 'Usage: vc dir [args]' '' 'Execute vim in {dir}'
  fi
}

vs() {
  vim "$@" -S
}
