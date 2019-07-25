# Open directory in Finder
alias finder='open -a Finder'
# Open an application
alias app='open -a'

# Move a file to Trash
trash () { mv "$@" ~/.Trash ; }

manpdf() {
  local manpage="$1"
  (( $# > 0 )) && shift
  local manargs=( "$@" )
  man -t "${manargs[@]}" "$manpage" | open -f -a Preview
}
