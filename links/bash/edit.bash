# Open a file
alias edit='$EDITOR'

# Open vim's Explore mode in current directory
alias explore='vim +Explore'

ed() {
  command ed -p: "$@"
}

# edit notes
enotes() {
  local dir="$(git rev-parse --absolute-git-dir 2>/dev/null)"
  local notes="${dir:-.}"/notes.md
  "$EDITOR" "$notes"
}
