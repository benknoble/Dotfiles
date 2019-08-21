# dotfiles

[![This project is personal](https://img.shields.io/badge/status-personal-important.svg)](https://benknoble.github.io/status/personal/)

My Dotfiles for configuration of different software and command-line programs

[See also: my workflow](https://gist.github.com/07052655c9b6ef75071a285102c61c93)

:warning:**WARNING**:warning: Dotfiles are _not_ meant to be forked: they are
personal castles that you should construct yourself. That said, feel free to
peruse mine and steal whatever you like.

In spite of the above warning, I have tried to make this repo relatively easy to
fork and play with. Sourcing local files, such as `~/.gitconfig.local`, is a
large part of that.

## Installing

First, clone the repo into your dotfiles directory (the name of the directory
doesn't matter).

```bash
mkdir ~/Dotfiles
git clone --recurse-submodules https://github.com/benknoble/Dotfiles.git ~/Dotfiles
cd ~/Dotfiles
```

Next, run `make` to kick things off:

```bash
./dotfiles.plink
make install
```

This will do several things:

1. Use [Plink](https://github.com/benknoble/plink) to generate the makefile.
1. Executes `make symlink`, which removes old files and creates the symlinks
   :warning:**No backups are made. Create your own prior to installing if you
   wish.**:warning:
2. (Optional) Executes `make $(FEATURES)`. See the [Makefile](/dotfiles.plink)
   for supported options and the defaults. `make FEATURES=none` can be used to
   skip this.

At this point, you may want to setup brew, so do

```bash
# Linux
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
# macOS
command -v brew
make brew_setup
```

The next time you start a shell (usually `bash`), your new `bashrc` will load
(or `bash_profile`, which simply sources the `bashrc`), giving you access to a
whole host of new command-line fu.

`reload` is a helpful alias for when changes have been made to dotfiles: it
essentially loads those changes into the environment.

### Keeping Up-to-date

`make update` should be all you need.

### Other `make` things

Controlled via Plink and dotfiles.plink.

The Makefile is _only_ guaranteed to work if run from the top-level of this
repo.

- provides useful targets (`make` prints a list)
- customizable (see the top section of Makefile)
- updates as needed

## Documentation & Full Feature List

Check the code—this is where you should probably *not* use something until you
understand what it is doing. Feel free to ask me questions.

The old docs have been eliminated. They can be found in the git history.

## Misc

### Terminal

I am now using and maintaining the [dracula theme][drac-term] full time for
Terminal.app. You can find it under the Dracula directory, along with a
`gitk(1)` theme.

### Built With

* [bash](https://www.gnu.org/software/bash/)
* [Mac OS X](https://en.wikipedia.org/wiki/OS_X_El_Capitan)
* [Terminal](https://en.wikipedia.org/wiki/Terminal_(macOS))
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

[drac-term]: https://github.com/dracula/terminal-app
