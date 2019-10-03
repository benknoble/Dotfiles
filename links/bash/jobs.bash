# Run htop for the current user's processes
uhtop() {
  htop -u "$USER" "$@"
}

# Jobs
alias j='jobs -l'
