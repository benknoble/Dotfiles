# Watch Star Wars
alias starwars='telnet towel.blinkenlights.nl'

# Read
alias news='newsboat'

# A format of the date
alias today='date -j +"%e %B %Y"'

freewrite() {
  local date="$(date -j +"%e-%B-%Y" | tr -d '[:space:]' | tr '-' ' ')"
  local file="$(date -j +"%e-%B-%Y" | tr -d '[:space:]')".md
  echo -e "Free-write $date\n\n" > "$file"
  vim +3 "$file"
}

markdownify() {
  # reads from stdin
  command=(
    curl
    --silent
    https://api.github.com/markdown/raw
    -X "POST"
    -H "Content-Type: text/x-markdown"
    --data-binary @-
  )
  "${command[@]}"
}
