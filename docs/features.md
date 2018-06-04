# Features

Here be dragons. Well, more like command-line fu(n).

I have grouped these into several categories:

- [bash](#bash)
- [git](#git)
- [vim](#vim)
- [brew](#brew)
- [tmux](#tmux)

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
- Sourcing all the provided `~/.bash/` files (see [bash files](#bash-files))
- Nullglob
- Noclobber, to prevent accidentally overwriting files
- Magic-space, which makes space expand history commands on the command line
- vi keybindings
- Bash history settings suitable for most modern computers
- Add Dotfiles/bin to PATH
- Add pip completion
- Add brew completion and external commands to PATH
- Custom `command_not_found_handle()` function
- Message of the Day on startup

### Bash Files

*PS1, aliases, colors, functions, and gitconfig.* These files give more
fine-tuned control over the bash setup without bloating the bashrc.

- **PS1** provides my fancy prompt, complete with functions to toggle it's pieces.
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

- **~/.private** is a place you can store exports of keys and things like that.
It will be sourced, but it doesn't get included in version control. Keep it
private.

- **~/.personal/** is a directory where you can keep personal tweaks. Every
`*.sh` file will get *sourced* (**not executed**) at startup. This is a great
place to tweak env variables unique to your machine, like COW, a completion
path, or a PATH. This is different from the **.private** above--this is meant to
be potentially version-controlled, so you get my setup, your tweaks, and no
conflicts. Particularly relevant if you work on multiple types of machines, and
some things need tweaks (`ls` flags, e.g.).

- **~/.personal/bin** is a directory of executables that gets added to your PATH
if it exists.

### Inputrc

*Tune input in bash.* Turns on some completion colors, enables vi key-strokes,
and customizes it. Reload with <C-x><C-r>.

### Bin

*Collection of useful or useless scripts.* Some good and some bad in here.

- **checkdistnoted** is for when the computer starts seriously lagging and you
suspect `distnoted` is the process sucking up the CPU. Run it and watch things
get fixed.

- **cowvis** is for seeing what all the cows from `cowsay` look like, and provides
you with their names so you can pick your favorites.

- **exit_msg** is a script I put together for exiting other scripts with a useful
message. Read it's docs.

- **figvis** is like cowvis: get a visual representation of fonts from
`figlet`

- **isnumber** takes input and decides whether it is a valid number or not.

- **itunes** gives you CLI control of iTunes. The disadvantage? If iTunes isn't
open, it will be after using this script.

- **listcmds** lists all of executables in your PATH (paged to `less`). Good for
finding out what's there.

- **loading** is good for displaying a quick loading bar that just infinitely
spins.

- **msgtest** is a stupid script for testing `exit_msg`

- **color-test** outputs colors for testing your terminal.

- **games** gives you a choice of games to run and then tries to start it in
  tmux, screen, or just regular bash for you.

### Terminal

*`benknoble.terminal` is a settings file for import into Terminal.* Import it to
have a nice, large Terminal screen with dark background and white font.

Alternately, use *`Dracula/terminal-app/Dracula.terminal`* for a Dracula color
theme.

## Git

### Gitconfig

*Contains important git aliases.* The caveat is that it also contains my user
info, so if you value your identity follow the installation prompts closely. You
may also want to run `setup/git-setup.sh` every now and then just in case.

Here's the quick list:

- **amend** for amending commits.

- **ca** for commit --all.

- **cc** for commit.

- **cd** for checking out branches.

- **cm** for commit with message passed as options.

- **grall** to graph with all references shown.

- **graph** for seeing a graph (oneline messages)

- **graph-long** for seeing a graph with long commits

- **last** for logging the last commit.

- **logp** for a pretty (verbose) log graph.

- **logpall** for `logp` with all references.

- **ls** for listing branches (and remotes; accepts -vva flags).

- **merc** creates a merge commit.

- **newb** creates a new branch.

- **sdiff** for collecting diffs from submodules.

- **spush** for pushing with automatic submodule pushing.

- **stat** for checking the status.

- **supdate** for updating all submodules.

- **unstage** for removing files from the staging area.

- **visual** for invoking `gitk`.

### Gitignore Global

*Ignores stupid backup files, .DS_Store on macOS, and .netrwhist from `Vim`.*

Also tags and .ackrc files.

### Git/ext

*External commands callable from `git`.* Just some easy things.

- **git weekly** gives you a weekly summary of a repo

- **git new** shows you the changes from the most recent HEAD change

- **git churn** to see what gets changed the most

- **git overwritten** is supposed to show what gets overwritten. It needs work.

Add the `-h` parameter for more information.

## Vim

### Vimrc

*Starts a lot of arguments.* Well, not too many. Like, I'm smart enough to `set
nocompatible`. Read the full file for all the features. Here's a quick look.

- `<Leader> = <Space>`

- Sets a lot of options my way. Read the file, or use `:set` or `:options` to see
them all.

- Incremental searching.

- Filetype plugins and syntax on.

- `Q` for formatting.

- Center results of common jumps (`n`, `G`, mouse click)

- Escape insert mode with all variations of `jj` and `jk`

- `gb` to fly through buffers! (Though unimpaired mappings work better.)

- Save with `<Leader>s`.

- Quit with `<Leader>q`.

- And do *all* the window things with a quick `<Leader>w`!

- Reload vimrc with `<F5>` or `:Reload`.

- Use the `Man` plugin! Finally, browse man pages from Vim.

- Serious plugin customization.

## Brew

See the Brewfile.

### Brewutils

*Collection of potentially useful `brew` scripts.* Source it and run
`brew_exists exists` to store whether or not brew can be found in `$exists`.

### Brew External Commands

*External commands callable from `brew`.* Just some easy things.

- **brew superclean** cleans up all the caches and extraneous downloads.

- **brew superupdate** upgrades `brew` and updates all the formulae.

Run `brew help <command>` for more help.

## Tmux

Uses `tpm` for plugin management.

See `tmux.conf` for configuration of keybindings and statusline.
