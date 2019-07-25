# Rerun last command [with prefix]
alias r='fc -s'

# most-often used commands, sorted by frequency
recent() {
  history | cut -c8- | cut -d" " -f1 | frequency | sort -rn | head
}
