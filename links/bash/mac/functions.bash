trash () { mv "$@" ~/.Trash ; }              # Move a file to Trash
getip() {
  ipconfig getifaddr en0
}

manpdf() {
  local manpage="$1"
  (( $# > 0 )) && shift
  local manargs=( "$@" )
  man -t "${manargs[@]}" "$manpage" | open -f -a Preview
}
