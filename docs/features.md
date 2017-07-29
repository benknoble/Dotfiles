# Features

Here be dragons. Well, more like command-line fu(n).

I have grouped these into several categories:

- [bash](#bash)
- [git](#git)
- [vim](#vim)
- [brew](#brew)

Within each, I have documented the features provided by various files.

## Bash

### Bashrc & Bash_profile

*Custom setup for bash*. `bash_profile` sources `bashrc`, allowing the setup to
remain constant no matter what.

`bashrc` provides the following:

- Setting EDITOR to `vim`
- Custom coloring for `ls`
- Message of the Day control
- Setting PS2 and PS3
- The `reload` alias
- Sourcing all the `bash/` files (see [bash files](#bash-files))
- Nullglob
- Noclobber, to prevent accidentally overwriting files
- Magic-space, which makes space expand history commands on the command line
- Bash history settings suitable for most modern computers
- Add Dotfiles/bin to PATH
- Add pip completion
- Add brew completion and external commands to PATH
- Message of the Day on startup!

### Bash Files

*PS1, aliases, colors, functions, and gitconfig.* These files give more
fine-tuned control over the bash setup without bloating the bashrc.

- **PS1** provides my fancy prompt, complete with functions to toggle it's pices.
Try typing `_toggle` at a command line and using tab-completion to see what's
available. Experiment, and find a setup that works for you. `_dirtrim` is also
provided, which sets the number of directories to keep in the prompt. With no
arguments, it defaults to 2. Otherwise, it uses the first argument.

- **aliases** provides my aliases. See [aliases](/docs/aliases.md).

- **functions** provides my functions. See [functions](/docs/functions.md).

- **colors** provides a series of useful color definitions and color builders.
They are mostly used for scripts, but you can use them yourself if you want to.
Notice how it starts with a series of simple numbers, then uses functions to
build colors with backgrounds, brightness, or other attributes.

The convention was that `B` is used for bright colors, `On` for background
colors, and the variables `CS,CE` for starting and ending color sequences in
PS1. `NC` is the color reset sequence.

- **gitconfig** has two jobs. First, it sets up the part of the prompt that is the
git status, based on whether or not it has git prompt scripts. Then, it adds git
completion if it can find it.

### Inputrc

*Tune input in bash.* This gives me opt+{left,right} in bash to move between
words on the command line and up and down to search history based on what's already
typed.

### Bin

*Collection of useful or useless scripts.* Some good and some bad in here.

- **checkdistnoted** is for when the computer starts seriously lagging and you
suspect `distnoted` is the process sucking up the CPU. Run it and watch things
get fixed.

- **cowvis** is for seeing what all the cows from `cowsay` look like, and provides
you with their names so you can pick your favorites.

- **exit_msg** is a script I put together for exiting other scripts with a useful
message. Read it's docs.

- **isnumber** takes input and decides whether it is a valid number or not.

- **itunes** gives you CLI control of iTunes. The disadvantage? If iTunes isn't
open, it will be after using this script.

- **listcmds** lists all of executables in your PATH (paged to `less`). Good for
finding out what's there.

- **loading** is good for displaying a quick loading bar that just infinitely
spins.

- **msgtest** is a stupid script for testing `exit_msg`

### Terminal

*`benknoble.terminal` is a settings file for import into Terminal.* Import it to
have a nice, large Terminal screen with dark background and white font.

## Git

### Gitconfig

*Contains important git aliases.* Here's the quick list:

- **cd** for checking out branches.

- **stat** for checking the status.

- **ls** for listing branches (and remotes; accepts -vva flags).

- **cc** for commit.

- **cm** for commit with message passed as options.

- **sdiff** for collecting diffs from submodules.

- **spush** for pushing with automatic submodule pushing.

- **supdate** for updating all submodules.

- **unstage** for removing files from the staging area.

- **last** for logging the last commit.

- **visual** for invoking `gitk`.

### Gitignore Global

*Ignores stupid backup files, .DS_Store on macOS, and .netrwhist from `Vim`.*

## Vim

### Vimrc

*Starts a lot of arguments.* Well, not too many. Like, I'm not stupid enough not
to not `set nocompatible`. Read the full file for all the features. Here's a
quick look.

- `<Leader> = <Space>`

- Sets a lot of options my way. Read the file, or use `:set` or `:options` to see
them all.

- Incremental searching.

- Filetype plugins and syntax on.

- Automatic fold column if the window entered has folds.

- `Q` for formatting.

- Center results of common jumps (`n`, `G`, mouse click)

- Escape insert mode with all variations of `jj` and `jk`

- `gb` to fly through buffers! (Though airline mappings work better.)

- Save with `<Leader>s`.

- Reload vimrc with `<F6>` or `:Reload`.

- Use the `Man` plugin! Finally, browse man pages from Vim.

- Serious plugin customization.

## Brew

### Brewutils

*Collection of potentially useful `brew` scripts.* Source it and run
`brew_exists exists` to store whether or not brew can be found in `$exists`.

### Brew External Commands

*External commands callable from `brew`.* Just some easy things.

- **brew dump** dumps all the `brew` formulae (and `Cask` apps) to standard
output, or the provided files.

- **brew superclean** cleans up all the caches and extraneous downloads.

- **brew superupdate** upgrades `brew` and updates all the formulae.

Run `brew help <command>` for more help.
