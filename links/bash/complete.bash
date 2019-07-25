# heroku completion
complete_heroku() {
  command -v heroku &> /dev/null \
    && eval "$(heroku autocomplete:script bash)"
}

# travis completion
complete_travis() {
  command -v travis &> /dev/null \
    && [[ -f ~/.travis/travis.sh ]] \
    && source ~/.travis/travis.sh
}
