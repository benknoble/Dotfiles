quote() {
  printf %s\\n "$1" | sed "s/'/'\\\\''/g;1s/^/'/;\$s/\$/'/"
}

# joinby delim args
join_by() {
  local d=$1
  shift
  echo -n "$1"
  shift
  printf "%s" "${@/#/$d}"
  echo
}

# report frequency of items on stdin
frequency() {
  sort | uniq -c | sort -g
}
