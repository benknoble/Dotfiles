alert() {
  local exit=$?
  local icon=utilities-terminal
  local subj="${1:-Alert}"
  (($# > 0)) && shift
  local msg="$*"
  if ((exit != 0)) ; then
    icon=dialog-error
  fi
  notify-send --urgency=low -i "$icon" "$subj" "$msg"
}
