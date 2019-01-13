#! /usr/bin/env bash
# PS1 printing and toggle functions

# vars

_value_on=true
_value_off=false
PROMPT_DIRTRIM=2
PROMPT_COMMAND=_build_PS1
_exit=0

# toggle functions

_toggle_date() {
  if [[ "$_show_date" = "$_value_on" ]]; then
    _show_date="$_value_off"
  else
    _show_date="$_value_on"
  fi
}

_toggle_user() {
  if [[ "$_show_user" = "$_value_on" ]]; then
    _show_user="$_value_off"
  else
    _show_user="$_value_on"
  fi
}

_toggle_host() {
  if [[ "$_show_host" = "$_value_on" ]]; then
    _show_host="$_value_off"
  else
    _show_host="$_value_on"
  fi
}

_toggle_jobs() {
  if [[ "$_show_jobs" = "$_value_on" ]]; then
    _show_jobs="$_value_off"
  else
    _show_jobs="$_value_on"
  fi
}

_toggle_tty() {
  if [[ "$_show_tty" = "$_value_on" ]]; then
    _show_tty="$_value_off"
  else
    _show_tty="$_value_on"
  fi
}

_toggle_shell_name() {
  if [[ "$_show_shell_name" = "$_value_on" ]]; then
    _show_shell_name="$_value_off"
  else
    _show_shell_name="$_value_on"
  fi
}

_toggle_time() {
  if [[ "$_show_time" = "$_value_on" ]]; then
    _show_time="$_value_off"
  else
    _show_time="$_value_on"
  fi
}

_toggle_dir() {
  if [[ "$_show_dir" = "$_value_on" ]]; then
    _show_dir="$_value_off"
  else
    _show_dir="$_value_on"
  fi
}

_toggle_history() {
  if [[ "$_show_history" = "$_value_on" ]]; then
    _show_history="$_value_off"
  else
    _show_history="$_value_on"
  fi
}

_toggle_venv() {
  if [[ "$_show_venv" = "$_value_on" ]]; then
    _show_venv="$_value_off"
  else
    _show_venv="$_value_on"
  fi
}

_dirtrim() {
  if [[ -z "$1" ]]; then
    PROMPT_DIRTRIM=2
  else
    PROMPT_DIRTRIM="$1"
  fi
}
# toggle vars

_show_date="$_value_off"
_show_user="$_value_on"
_show_host="$_value_on"
_show_jobs="$_value_on"
_show_tty="$_value_off"
_show_shell_name="$_value_off"
_show_time="$_value_off"
_show_dir="$_value_on"
_show_history="$_value_on"
_show_venv="$_value_on"

# display functions

_date_prompt() {
  if [[ "$_show_date" = "$_value_on" ]]; then
    echo '\D{%e %B %Y} '
  fi
}

_user_prompt() {
  if [[ "$_show_user" = "$_value_on" ]]; then
    if [[ "$_show_host" = "$_value_on" ]]; then
      echo '\u @ \h '
    else
      echo '\u '
    fi
  fi
}

_jobs_prompt() {
  if [[ "$_show_jobs" = "$_value_on" ]]; then
    echo '{\jj} '
  fi
}

_tty_prompt() {
  if [[ "$_show_tty" = "$_value_on" ]]; then
    echo '\l '
  fi
}

_shell_name_prompt() {
  if [[ "$_show_shell_name" = "$_value_on" ]]; then
    echo '\s-\V '
  fi
}

_time_prompt() {
  if [[ "$_show_time" = "$_value_on" ]]; then
    echo '\t⧖ '
  fi
}

_dir_prompt() {
  if [[ "$_show_dir" = "$_value_on" ]]; then
    echo '∈ \w '
  fi
}

_history_prompt() {
  if [[ "$_show_history" = "$_value_on" ]]; then
    echo '#\! '
  fi
}

_venv_prompt() {
  if [[ "$_show_venv" = "$_value_on" ]]; then
    if [[ -n "$VIRTUAL_ENV" ]]; then
      local venv
      venv="$(basename "$(dirname "$VIRTUAL_ENV")")"
      echo "($venv) "
    fi
  fi
}


# build PS1

_build_PS1() {
  _exit="$?"
  local highlight
  local exit_sym
  local cols=$(tput cols)
  local p=""
  local len=0
  local newline=""

  if [[ "$_exit" = "0" ]]; then
    highlight="$BGreen"
    exit_sym='✓'
  else
    highlight="$BRed"
    exit_sym="✗ $_exit"
  fi

  p="$(_venv_prompt)$(_time_prompt)$(_date_prompt)$(_jobs_prompt)$(_history_prompt)$exit_sym $(_tty_prompt)$(_shell_name_prompt)$(_user_prompt)$(_dir_prompt)\$("$__gps1")"'\$ '
  qp="${p@P}"
  len="${#qp}"
  if (( len > cols / 2 )); then
    newline=$'\n'
  fi

  PS1="$(_venv_prompt)$CS$Yellow$CE$(_time_prompt)$(_date_prompt)$CS$NC$CE$CS$BGreen$CE$(_jobs_prompt)$CS$NC$CE$CS$BMagenta$CE$(_history_prompt)$CS$NC$CE$CS$highlight$CE$exit_sym$CS$NC$CE $CS$Green$CE$(_tty_prompt)$(_shell_name_prompt)$CS$NC$CE$(_user_prompt)$CS$BCyan$CE$(_dir_prompt)$CS$NC$CE$CS$BYellow$CE\$("$__gps1")$CS$NC$CE$newline"'\$ '
}
