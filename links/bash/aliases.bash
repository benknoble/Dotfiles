#! /usr/bin/env bash
# alias definitions

alias quit='exit'                           # Because Mac OS X tends to call it quit
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias hidden='ls -a | grep "^\."'           # List all hidden files
alias ~='cd ~'                              # Shortcut to cd ~
alias edit='$EDITOR'                        # Open a file
alias explore='vim +Explore'                # Open vim's Explore mode in current directory
alias starwars='telnet towel.blinkenlights.nl'      # Watch Star Wars
alias beep="echo -n $'\a'"                  # Do a beep
alias today='date -j +"%e %B %Y"'           # A format of the date
alias lvim='vim -c "normal '"'0"'"'         # Start vim with it's last cursor position
alias uhtop='htop -u $USER'                 # Run htop for the current user's processes
alias r='fc -s'                             # Rerun last command [with prefix]
alias j='jobs -l'                           # Jobs
alias ducks='du -cks * | sort -rn | head'   # Ducks!
alias nocomment='grep -Ev "^(#|$)"'         # No comment...
alias g='git'
