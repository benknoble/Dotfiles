# Ducks!
alias ducks='du -cks * | sort -rn | head'
# No comment...
alias nocomment='grep -Ev "^(#|$)"'

# Find Pid of specified process
findPid () { lsof -t -c "$@" ; }

pj() {
  ps $(jobs -l | fields 2)
}

# Run htop for the current user's processes
uhtop() {
  htop -u "$USER" "$@"
}

# Jobs
alias j='jobs -l'

ports() {
  if (($# == 0)) ; then
    {
      echo 'usage: ports port...'
      echo
      echo 'describe services on port...'
    } >&2
  else
    lsof ${@/#/-i :}
  fi
}
