# dotfiles
Dotfiles for configuration of different software

So far this includes a vimrc, bashrc, and bash_profile that utilizes bashrc.
There is also an install-all.sh script which will prompt for and install some custom features, like brew or vim-airline. It is primarily useful for new machine setups.
There is also an updateDotfiles alias provided which will attempt to pull recent updates from origin/master (this repo). Use it to keep your files up-to-date without learning git (if you want).
I wrote a few utils for brew to make my life easier, and provided aliases for
those as well. You can view all aliases with the `aliases` command, and
functions with the `functions` command.

Most of the code is either garnered from webcrawling or help files, so feel free to use it as there are no proprietary rights attached. A decent portion of it I actually figured out myself.
And of course, it's yours to change too if you prefer a different set up.

If you create a really awesome feature that you want to share, send a pull request. I love cool features, especially if they make me more productive.

The file benknoble.terminal is an XML file for use with Apple's *Terminal*
application; it is a settings file ready for import.

## Usage

First, clone the repo into your dotfiles directory

> $ mkdir Dotfiles && cd Dotfiles
>
> $ git clone https://github.com/benknoble/Dotfiles.git

Then run the makesymlinks script

> $ ./makesymlinks.sh

If this doesn't work, you probably need to make it executable with

> $ chmod +x makesymlinks.sh

## Install usage

Run the install-all script

> $ ./install-all.sh

If this doesn't work, you probably need to make it executable with

> $ chmod +x install-all.sh

## Update usage

Run the update script to pull in any changes from the remote

> $ ./update.sh

If this doesn't work, you probably need to make it executable with

> $ chmod +x update.sh
