# Ducks!
alias ducks='du -cks * | sort -rn | head'
# No comment...
alias nocomment='grep -Ev "^(#|$)"'

# Find Pid of specified process
findPid () { lsof -t -c "$@" ; }

pj() {
  ps $(jobs -l | fields 2)
}
