#! /bin/bash -
# git config

# add git branch to prompt when available and colorize
gitprompt=/usr/local/etc/bash_completion.d/git-prompt.sh
if [[ -s "$gitprompt" ]]; then
  . "$gitprompt"
  GIT_PS1_SHOWDIRTYSTATE='true'
  GIT_PS1_SHOWSTASHSTATE='true'
  GIT_PS1_SHOWUNTRACKEDFILES='true'
  GIT_PS1_SHOWUPSTREAM='auto'
  GIT_PS1_STATESEPARATOR=' '
  GIT_PS1_DESCRIBE_STYLE='branch'
  __gps1="__git_ps1 '%s '"
else
  __gps1="git branch --no-color 2>/dev/null | grep '^*' | colrm 1 2"
fi
