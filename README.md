# dotfiles

My Dotfiles for configuration of different software and command-line programs

**WARNING** Dotfiles are _not_ meant to be forked: they are personal castles
that you should construct yourself. That said, feel free to peruse mine and
steal whatever you like. Attribute me if you want, or don't. I don't care.

In spite of the above warning, I have tried to make this repo easy-ish to fork
and play with. Sourcing local files, such as `~/.gitconfig.local`, is a large
part of that.

## Installing

First, clone the repo into your dotfiles directory. You can name it anything,
but make sure to override the variable `DOTFILES` when invoking `make`. (_Note:_
[Name Dependencies](#name-dependencies).)

```bash
$ mkdir ~/Dotfiles

$ git clone --recurse-submodules https://github.com/benknoble/Dotfiles.git ~/Dotfiles

$ cd ~/Dotfiles
```

Next, run `make` to kick things off:

```bash
$ DOTFILES=/path/to/cloned/project make install
```

This will do several things:

1. Executes `make symlink`, which backs up old conf files and symlinks
   the files here
2. (Optional) Executes `make _features`, which in turn executes `make` for each
   of the features in the override-able `FEATURES` variable. See the
   [Makefile](/Makefile) for supported options and the defaults.

The next time you start a shell (usually `bash`), your new `bashrc` will load
(or `bash_profile`, which simply sources the `bashrc`), giving you access to a
whole host of new command-line fu. If you don't want to wait, try

```bash
$ source ~/.bashrc
$ reload
```

`reload` is a helpful alias for when changes have been made to dotfiles: it
essentially loads those changes into the environment.

### Keeping Up-to-date

`make update` should be all you need.

### Other `make` things

The Makefile is _only_ guaranteed to work if run from the top-level of this
repo.

- provides useful targets (`make` prints a list)
- customizable (`grep '?=' Makefile`)

## Documentation & Full Feature List

Eliminated. Can be found in the git history.

## Misc

### Terminal

The file benknoble.terminal is an XML file for use with Apple's *Terminal*
application; it is a settings file ready for import.

### Name Dependencies

The following files depend on the structure `~/Dotfiles` and must be edited to
use a different directory:

- [/bashrc](/links/bashrc)
- [/bash/aliases.bash](/links/bash/aliases.bash)

### Built With

* [bash](https://www.gnu.org/software/bash/)
* [Mac OS X](https://en.wikipedia.org/wiki/OS_X_El_Capitan)
* [Terminal](https://en.wikipedia.org/wiki/Terminal_(macOS)
* [Vim](https://github.com/vim/vim)
* [Git](https://git-scm.com)
* [Homebrew/brew](https://brew.sh)

And of course, a host of plugins, scripts, aliases, and some serious TLC :heart:.

I guess there's a little [python](https://www.python.org) in there... it's
actually quite good stuff.

(I didn't forget you GitHub! Thanks for generously hosting this repo.)

## Contributing

Please see our [Contributing Guidelines](/CONTRIBUTING.md) for information on
how to get involved.

### Code of Conduct

Note that we also have a [Code of Conduct](/CODE_OF_CONDUCT.md) that governs the
behavioral expectations of the Dotfiles.

## License

This project is licensed under the MIT License--see [LICENSE](/LICENSE) for more
information.

© 2016 David Ben Knoble

## Acknowledgments

This project was inspired by a [blog
post](http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/)
from [this guy](https://github.com/michaeljsmalley).

I've also grabbed code from a number of places over the development of the
project. I've tried to attribute you in the code where possible, but I can't hit
everybody.

Thanks to [Steve Losh](http://stevelosh.com/blog/2010/09/coming-home-to-vim/)
for some Vim help and [teaching](http://learnvimscriptthehardway.stevelosh.com).

Thanks further to the kind Internet for providing a wealth of resources when
things go wonky.
