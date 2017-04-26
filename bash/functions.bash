#! /bin/bash -
#function definitions

cdls () { cd "$@" && ls ; }                  # cd and ls
trash () { mv "$@" ~/.Trash ; }              # Move a file to Trash
aliases () { cat ~/Dotfiles/bash/aliases.bash | tail -n +4 ; }                        # List all aliases found in this file
functions () { cat ~/Dotfiles/bash/functions.bash | tail -n +4 ; }                    # List all functions found in this file
findPid () { lsof -t -c "$@" ; }             # Find Pid of specified process
displayPath () { for path in "${PATH//:/ }"; do echo "$path"; done; }                 # Print path separated by newlines
mkcd () { mkdir "$@" && cd "$@" ; }          # mkdir and cd
editall () { vim -p "$@" ; }                 # edit all files provided as arguments in vim tabs
extract () {                                 # attempt to extract file with correct extraction method
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)  tar xjf "$1"      ;;
            *.tar.gz)   tar xzf "$1"      ;;
            *.bz2)      bunzip2 "$1"      ;;
            *.rar)      rar x "$1"        ;;
            *.gz)       gunzip "$1"       ;;
            *.tar)      tar xf "$1"       ;;
            *.tbz2)     tar xjf "$1"      ;;
            *.tgz)      tar xzf "$1"      ;;
            *.zip)      unzip "$1"        ;;
            *.Z)        uncompress "$1"   ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

pathadd() {                                 # add to path
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

vimupdate() {
    if [ -d ~/.vim/bundle ]; then
        for dir in `ls ~/.vim/bundle`; do
            echo
            echo ~/.vim/bundle/"$dir"
            echo "$(date)"
            (cd ~/.vim/bundle/"$dir" && git checkout master && git pull)
            echo
        done
    fi
}

freewrite() {
    date="$(date -j +"%e %B %Y")"
    file="$(echo "$date" | tr ' ' '-').md"
    echo -e "Free-write $date\n\n" > "$file"
    vim +3 "$file"
}
