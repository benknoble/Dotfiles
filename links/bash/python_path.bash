#! /usr/bin/env bash

if command -v python3 >/dev/null 2>&1 ; then

  python_path="$(python3 - <<SNAKE
import site
import os.path as path
print(path.join(site.USER_BASE, 'bin'))
SNAKE
)"
  pathadd "$python_path"

fi
