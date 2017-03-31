# dotfiles
Dotfiles for configuration of different software

So far this includes a vimrc, bashrc, and bash_profile that utilizes bashrc.
There is also an install-all.sh script which will prompt for and install some custom features, like brew or vim-airline. It is primarily useful for new machine setups.
There is also an `updateDotfiles` alias provided which will attempt to pull recent updates from origin/master (this repo). Use it to keep your files up-to-date without learning git (if you want).
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

```bash
$ mkdir Dotfiles && cd Dotfiles

$ git clone https://github.com/benknoble/Dotfiles.git
```

Then run the makesymlinks script

```bash
$ ./makesymlinks.sh
```

If this doesn't work, you probably need to make it executable with

```bash
$ chmod +x makesymlinks.sh
```

This should set up symlinks for config files, which will take effect when you
load a new Terminal session. Alternatively, you could `source ~/.bashrc` to get things going. A helpful alias is `reload` to bring any changes
into affect.

## Install usage

Run the install-all script

```bash
$ ./install-all.sh
```

If this doesn't work, you probably need to make it executable with

```bash
$ chmod +x install-all.sh
```

The purpose of this script is to make use of the `/installers` directory, which
contains scripts used to install various things (brew tools, vim plugins, git
completion scripts, &c.), and it also configures git.

The scripts are organized by dependencies, so choosing not to install brew will
skip anything brew dependent. You can also run each script individually, e.g. to
fix a broken install or to later install something not previously done. The
gitconfig script can also be used to recover those settings.

## Update usage

Run the update script to pull in any changes from the remote

```bash
$ ./update.sh
```

If this doesn't work, you probably need to make it executable with

```bash
$ chmod +x update.sh
```

This script will pull in changes from the configured remote origin. You'll need
to pull in upstream changes manually if you forked this on GitHub.
