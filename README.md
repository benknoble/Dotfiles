# dotfiles
Dotfiles for configuration of different software

So far this includes a vimrc, bash_profile, and a stupidly simple bashrc that sources bash_profile.

Most of the code is either garnered from webcrawling or help files, so feel free to use it as there are no proprietary rights attached.

If you create a really awesome feature that you want to share, send a pull request. I love cool features, especially if they make me more productive.

## Usage

First, clone the repo into your home directory

> $ git clone https://github.com/benknoble/Dotfiles.git

Then, cd into your new Dotfiles directory

> $ cd Dotfiles

and run the makesymlinks script

> $ ./makesymlinks.sh

If this doesn't work, you probably need to make it executable with

> $ chmod +x makesymlinks.sh
