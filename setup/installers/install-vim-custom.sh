#! /usr/bin/env bash
# installer script for Pathogen and certain vim plugins

echo
echo "Install custom vim..."
echo

echo 'Previous vim plugins are now included as submodules. If you cloned using
the `--recursive` option, they have been properly cloned symlinked with the vim
directory. If not, you will need `git submodule init; git submodule update`.'
echo

echo "...done with custom vim"
echo
