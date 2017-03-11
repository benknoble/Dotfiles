#! /bin/bash
# an install script to install custom stuff
# executes all scripts in ./installers/, which makes it prone to attack if not careful.
# however, it also allows you to add your own installer scripts

find ./installers/*.sh -maxdepth 1 -exec {} \;
