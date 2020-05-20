# this cannot be autoloaded because ~/.zshfn/g === ~/.zshfn/G
# (at least on my mac)
G () {
  grep --color=auto "$@"
}
compdef ${_comps[grep]} G

# and while we're here
EG () {
  grep -E --color=auto "$@"
}
compdef ${_comps[grep]} EG
