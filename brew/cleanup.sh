#!/bin/bash
# cleans up the cache and outdated version downloads

source ./brewutils.sh

brew_exists exists
if [[ "$exists" -eq "0" ]]; then
	echo "brew found"
	brew cleanup -s
else
	echo "brew not found"
fi
