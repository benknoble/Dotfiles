#! /bin/bash
# updates brew, upgrades formula (removes old versions)

source "$brewscripts/brewutils.sh"

brew_exists exists
if [[ "$exists" -eq "0" ]]; then
    echo "brew found"
    brew update
    brew upgrade --cleanup
else
    echo "brew not found"
fi
