# this cannot be autoloaded because ~/.zshfn/g === ~/.zshfn/G
# (at least on my mac)
G () {
  grep --color=auto "$@"
}

# and while we're here
EG () {
  grep -E --color=auto "$@"
}
