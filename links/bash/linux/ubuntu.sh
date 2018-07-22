if [[ -d ~/.local/bin ]] ; then
  pathadd ~/.local/bin
fi

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if ! shopt -oq posix ; then
  if [ -f /usr/share/bash-completion/bash_completion ] ; then
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi
fi
