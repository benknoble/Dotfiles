alert() {
  local exit=$?
  local icon=terminal
  local subj="${1:-Alert}"
  (($# > 0)) && shift
  local msg="$*"
  if ((exit != 0)) ; then
    icon=error
  fi
  notify-send --urgency=low -i "$icon" "$subj" "$msg"
}
