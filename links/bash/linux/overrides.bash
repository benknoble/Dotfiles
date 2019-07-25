if [ -x /usr/bin/dircolors ]; then
  if [[ -r ~/.dircolors ]]; then
    eval "$(dircolors -b ~/.dircolors)"
  else
    eval "$(dircolors -b)"
  fi
  alias ls='ls -F --color=auto'
  alias grep='grep --color=auto'
  alias egrep='egrep --color=auto'
  alias fgrep='fgrep --color=auto'
fi

alias lsa='ls -a'
alias ll='ls -l'
alias lla='ll -a'
alias lh='ll -h'
alias lha='lla -h'
