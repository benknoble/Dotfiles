# dotfiles
My Dotfiles for configuration of different software and command-line programs

You can find the [directory structure here](/docs/tree.md) [generated with `tree
-L 3 --noreport`].

Find us on Gitter!

[![Gitter chat](https://badges.gitter.im/benknoble-Dotfiles/Lobby.png)](https://gitter.im/benknoble-Dotfiles/Lobby)

## Features

- bashrc/inputrc for making bash more fun
- (controversial) vimrc/vim for starting arguments about vim settings
- git config/ignore files for git settings and aliases
- brew and cask formulae
- lots of useful scripts

See [Full Feature List](#documentation--full-feature-list)

## Installing

First, clone the repo into your dotfiles directory. This directory needs to be
named Dotfiles, otherwise many of the scripts and aliases will fail. I'm looking
into solving this problem, but for now see [Name
Dependencies](#name-dependencies) (see also #31).

```bash
$ mkdir ~/Dotfiles && cd ~/Dotfiles

$ git clone --recursive https://github.com/benknoble/Dotfiles.git
```

Next, run the `bootstrap` script to kick things off:

```bash
$ ./bootstrap.sh            # or bash bootstrap.sh
```

This will do several things; if you want to do them individually, you need to
execute the scripts in the setup directory yourself. `bootstrap` is pretty
verbose though, and works best.

1. Executes `./setup/makesymlinks.sh`, which backs up old conf files and symlinks
   the files here
2. (Optional) Executes `./setup/install-all.sh`, which in turn executes any
   scripts in `./installers`. Understandably, this is brittle. You may wish to
   inspect the scripts yourself to verify nothing malicious is happening, but
   the scripts are supposed to install *brew* (+utils), *vim* plugins, and *git*
   extras. They are organized by dependency (e.g., skipping brew skips anything
   installed by brew), and they will prompt for confirmation at each step. You
   can execute them yourself if you want to deal with it later, or to reinstall
   something removed. See [what's installed](/docs/installed.md).
3. Executes `./setup/git-setup.sh`, which has two tasks. It confirms the git
   user name and email, allowing you to set your own, and wires up the global
   gitignore file to point to the right spot.

The next time you start a Terminal session, your new bashrc will load (or
bash_profile, which simply sources the bashrc), giving you access to a whole
host of new command-line fu. If you don't want to wait, try

```bash
$ source ./bashrc           # Or ~/.bashrc, which points here
$ reload
```

`reload` is a helpful alias for when changes have been made to dotfiles: it
essentially loads those changes into the environment. (See
[aliases](/docs/aliases.md))

## Keeping Up-to-date

Since this repo is constantly in development, you may find you want to pull in
changes from the origin (or upstream remote if you forked this on GitHub).

I have provided a simple (and thus imperfect) mechanism for doing so:
`update.sh`. Aliased to execute with `updateDotfiles`, the script will checkout
the master branch and pull in changes. This really only works if you just cloned
the repo using the GitHub link, or if you forked and then cloned your fork.

If you want to pull updates from this repo for a fork, you'll need to add this
as upstream.

If you want a different update setup, you should learn git. Make sure that this
repository is an upstream remote, and that your fork (you did fork, right?) is
origin. This way you can diverge from the original project some, but still send
PRs fairly easily. Of course, you can always `git fetch --all` or `git pull
upstream master` to fetch updates.

## Documentation & Full Feature List

See the [docs](/docs) folder. You thought I was just gonna leave all that info
here.

Also try [features](/docs/features.md).

## Misc

### Terminal

The file benknoble.terminal is an XML file for use with Apple's *Terminal*
application; it is a settings file ready for import.

### Name Dependencies

The following files depend on the structure `~/Dotfiles` and must be edited to
use a different directory:

- [/bashrc](/bashrc)
- [/bootstrap.sh](/bootstrap.sh)
- [/bash/aliases.bash](/bash/aliases.bash)
- [/bash/functions.bash](/bash/functions.bash)
- [/setup/install-all.sh](/setup/install-all.sh)
- [/setup/makesymlinks.sh](/setup/makesymlinks.sh)
- [/update.sh](/update.sh)

### Built With

* [bash 4.x.x](https://www.gnu.org/software/bash/)
* [Mac OS X 10.11.6](https://en.wikipedia.org/wiki/OS_X_El_Capitan) (I'm slow to
  upgrade usually) and
  [Terminal](https://en.wikipedia.org/wiki/Terminal_(macOS))
* [Vim 8.0.x](https://vim.sourceforge.io), because *duh*.
* [Git 2.13.x](https://git-scm.com)
* [Homebrew/brew](https://brew.sh)

And of course, a host of plugins, scripts, aliases, and some serious TLC :heart:.

I guess there's a little [python](https://www.python.org) in there... it's
actually quite good stuff.

(I didn't forget you GitHub! Thanks for generously hosting this repo.)
