# Open a file
alias edit='$EDITOR'

# Open vim's Explore mode in current directory
alias explore='vim +Explore'

ed() {
  command ed -p: "$@"
}

# edit notes
vnotes() {
  local notes=./notes.md
  if git status >/dev/null 2>/dev/null ; then
    notes="$(git rev-parse --absolute-git-dir)/notes.md"
  fi
  "$EDITOR" "$notes"
}
