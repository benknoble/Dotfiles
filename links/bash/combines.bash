# mkdir and cd
mkcd () { mkdir "$@" && cd "$@" ; }

# cd and ls
cdls () { cd "$@" && ls ; }

# mktouch path/to/file ...
mktouch() {
  if (( $# < 1 )); then
    echo "Missing argument" >&2
    return 1
  fi

  for f in "$@"; do
    mkdir -p -- "$(dirname -- "$f")"
    touch -- "$f"
  done
}
