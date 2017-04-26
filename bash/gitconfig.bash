#! /bin/bash -
# git config

#add git branch to prompt when available and colorize
if [[ -s ~/.git-prompt.sh ]]; then
    . ~/.git-prompt.sh
    export GIT_PS1_SHOWDIRTYSTATE='true'
    export GIT_PS1_SHOWSTASHSTATE='true'
    export GIT_PS1_SHOWUNTRACKEDFILES='true'
    export GIT_PS1_SHOWUPSTREAM='auto'
    export GIT_PS1_STATESEPARATOR=' '
    export __gps1="__git_ps1 '%s '"
else
    export __gps1="git branch 2>/dev/null | grep '^*' | colrm 1 2"
fi

#add git autocompletion, if it exists
[[ -s ~/.git-completion.bash ]] && . ~/.git-completion.bash
