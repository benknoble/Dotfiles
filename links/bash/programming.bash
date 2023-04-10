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

# input: data count
histogram() {
  barchart "$@"
}

nearest_ten() {
  # 0-9 actually don't change
  awk '{ printf "%d\n", sprintf("%1.0e", $0) }'
}

# combine my most used histogram technique into one
bucket10 () {
  nearest_ten | frequency | sort -k2 | histogram
}

fold() {
  sed '2,$s,$,'"$1"',' | awk "BEGIN{print \"${2:-10}k\"} 1 END{print \"f\"}" | dc
}

sum() {
  fold +
}

avg() {
  awk '{ sum += $0 } END{ print sum/NR }'
}
