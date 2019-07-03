#! /usr/bin/env bash

if command -v python3 >/dev/null 2>&1 ; then

  python_path="$(python3 -m site --user-base)/bin"
  pathadd "$python_path"

fi
