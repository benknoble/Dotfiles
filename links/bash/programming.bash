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
  awk '{
    printf "%s\t", $1
    for(i = 0; i < int($2); i++)
        printf "*"
    printf "\n"
  }'
}

# for use after frequency
histogram_f() {
  fields 2 1 | sort -g | histogram
}

nearest_ten() {
  # 0-9 actually don't change
  awk '{ printf "%d\n", sprintf("%1.0e", $0) }'
}

# combine my most used histogram technique into one
bucket10 () {
  nearest_ten | frequency | histogram_f
}

fold() {
  sed '2,$s,$,'"$1"',' | awk "BEGIN{print \"${2:-10}k\"} 1 END{print \"f\"}" | dc
}

sum() {
  fold +
}

avg() {
  awk '{ sum += $0 } END{ print sum/NF }'
}
