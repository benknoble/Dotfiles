#! /bin/bash -

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return ;;
esac

if [[ -f ~/.bashrc ]]; then
    source ~/.bashrc
fi
