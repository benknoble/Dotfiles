# dotfiles
Dotfiles for configuration of different software and command-line programs

Directory structure (output of `tree -L 3 --noreport`)
```
.
├── README.md
├── bash
│   ├── aliases.bash
│   ├── colors.bash
│   ├── functions.bash
│   └── gitconfig.bash
├── bash_profile
├── bashrc
├── benknoble.terminal
├── bootstrap.sh
├── brew
│   ├── README.md
│   ├── brewutils.sh
│   ├── cleanup.sh
│   └── update.sh
├── gitconfig
├── gitignore_global
├── inputrc
├── installers
│   ├── install-brew.sh
│   ├── install-git-extras.sh
│   └── install-vim-custom.sh
├── setup
│   ├── git-setup.sh
│   ├── install-all.sh
│   └── makesymlinks.sh
├── update.sh
├── vim
│   ├── autoload
│   ├── bundle
│   │   ├── vim-airline
│   │   ├── vim-airline-themes
│   │   ├── vim-auto-pairs
│   │   ├── vim-ctrlp
│   │   ├── vim-fugitive
│   │   ├── vim-invader
│   │   ├── vim-pathogen
│   │   ├── vim-syntastic
│   │   ├── vim-windowswap
│   │   └── vim-winresizer
│   └── spell
│       ├── en.utf-8.add
│       └── en.utf-8.add.spl
└── vimrc
```

## Features

- bashrc for making bash more fun
- vimrc/vim for starting arguments about vim settings
- git config/ignore files for git settings and aliases
- lots of useful scripts

See [Full Feature List](#documentation--full-feature-list)

**Planned Ideas**

- [ ] To come...


## Getting Started

First, clone the repo into your dotfiles directory. This directory needs to be
named Dotfiles, otherwise many of the scripts and aliases will fail. I'm looking
into solving this problem, but for now see [Name
Dependencies](#name-dependencies).

```bash
$ mkdir ~/Dotfiles && cd ~/Dotfiles

$ git clone --recursive https://github.com/benknoble/Dotfiles.git
```

Next, run the `bootstrap` script to kick things off:

```bash
$ ./bootstrap.sh    # or bash bootstrap.sh
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
   something removed.
3. Executes `./setup/git-setup.sh`, which has two tasks. It confirms the git
   user name and email, allowing you to set your own, and wires up the global
   gitignore file to point to the right spot.

The next time you start a Terminal session, your new bashrc will load (or
bash_profile, which simply sources the bashrc), giving you access to a whole
host of new command-line fu. If you don't want to wait, try

```bash
$ source ./bashrc && reload
```

`reload` is a helpful alias for when changes have been made to dotfiles: it
essentially loads those changes into the environment. (See
[aliases](/docs/aliases.md))

## Keeping Up-to-date

Since this repo is constantly in development, you may find you want to pull in
changes from the origin (or upstream remote if you forked this on GitHub). I
have provided a simple mechanism for doing so: `update.sh`. Aliased to execute
with `updateDotfiles`, the script will checkout the master branch and pull in
changes. Should you have set origin to your fork, it will pull from the fork;
otherwise, from this repo. If you want to pull in from upstream, you need to use
`git pull upstream master` on the command line or simply edit `update.sh`

## Documentation & Full Feature List

See the [docs](/docs) folder.

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

