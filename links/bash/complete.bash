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

_pip_completion()
{
  COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
    COMP_CWORD=$COMP_CWORD \
    PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip3


# vault completion
vault_path="$(command -v vault)"
if [[ -n "$vault_path" ]] ; then
  complete -C "$vault_path" vault
fi
unset vault_path
