#!/bin/bash
#git config

#add git branch to prompt when available and colorize
if [[ -s ~/.git-prompt.sh ]]; then
    . ~/.git-prompt.sh
    export GIT_PS1_SHOWDIRTYSTATE='true'
    export GIT_PS1_SHOWSTASHSTATE='true'
    export GIT_PS1_SHOWUNTRACKEDFILES='true'
    export GIT_PS1_SHOWUPSTREAM='auto'
    export GIT_PS1_STATESEPARATOR=' '
    export PS1="$CS$BPURPLE$CE\!$CS$NC$CE $CS$BWHITE$CE\u$CS$NC$CE:$CS$BCYAN$CE\W$CS$NC$CE $CS$BYELLOW$CE\$(__git_ps1 '%s ')$CS$NC$CE\$ "
else
    export PS1="$CS$BPURPLE$CE\!$CS$NC$CE $CS$BWHITE$CE\u$CS$NC$CE:$CS$BCYAN$CE\W$CS$NC$CE $CS$BYELLOW$CE\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)$CS$NC$CE\$ "
fi

#add git autocompletion, if it exists
[[ -s ~/.git-completion.bash ]] && . ~/.git-completion.bash

#some useful git aliases
git config --global --replace-all alias.cd checkout
git config --global --replace-all alias.stat status
git config --global --replace-all alias.ls branch
git config --global --replace-all alias.cc commit
git config --global --replace-all alias.cm 'commit -m'
git config --global --replace-all merge.tool vimdiff
git config --global --replace-all merge.conflictstyle diff3
git config --global --replace-all color.ui true
git config --global --replace-all core.autocrlf input
