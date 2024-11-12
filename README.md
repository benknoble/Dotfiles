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
doesn't matter). If your git supports it, `--jobs ...` might be a good idea. You
can skip the submodules if you choose, but you *must* have the zuo submodule or
a [zuo](https://docs.racket-lang.org/zuo/index.html) installation to execute
build instructions used for installation and maintenance. The submodule is the
easiest route.

```bash
mkdir ~/Dotfiles
git clone --recurse-submodules https://github.com/benknoble/Dotfiles.git ~/Dotfiles
cd ~/Dotfiles
```

Next, run `./compile-zuo` to kick things off:

```bash
./compile-zuo
zuo . install
```

This will do several things:

1. Build [zuo](https://docs.racket-lang.org/zuo/index.html).
1. Install symlinks with `zuo . symlink`, which removes old files and creates
   the symlinks. :warning:**No backups are made. Create your own prior to
   installing if you wish.**:warning:
2. (Optional) Run `zuo . $(FEATURES)`. See the [zuo script](main.zuo) for
   supported options and the defaults. Setting `FEATURES` to an empty string can
   be used to skip this.

At this point, you may want to setup brew, so do

```bash
# Linux
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
# macOS
command -v brew

zuo . brew-setup
```

The next time you start a shell (probably homebrewed `zsh`, since that's what
`zuo . brew-setup` sets it to), your new config files will load, giving you
access to a whole host of new command-line fu.

`reload` is a helpful alias (defined for both `bash` and `zsh`) for when changes
have been made to shell dotfiles: it essentially loads those changes into the
environment. `:Reload` exists for `vim`, and there are reload bindings for both
`tmux` and `readline` as well.

### Keeping Up-to-date

`zuo . update` should be all you need.

### Other `zuo` things

The build script is _only_ guaranteed to work if run from the top-level of this
repo. It does use zuo-isms to try to work elsewhere, but I haven't really tested
it.

Several useful targets are supported. `zuo .` prints a list.

## Development

A handful of useful Git aliases to add locally:

```
[alias]
	plugins = !git ca -m 'all: update plugins'
	spell = !git cc links/vim/spell/ -m 'vim: update spellfile'
	brew = !git cc brew -m 'brew: update Brewfile'
```

## Documentation & Full Feature List

Check the code—this is where you should probably *not* use something until you
understand what it is doing. Feel free to ask me questions.

The old docs have been eliminated. They can be found in the git history.

## Misc

### Theme

I am now using the Dracula themes for all my software. You can find some of them
under the Dracula directory and some in a Vim package. Some are hand-coded and
not official. Additionally, if Dracula Pro is available, I'm using that instead.
I usually use the Van Helsing variant, though the regular variant is also nice.

I'm using Victor Mono as a font. Cursive italics have grown on me; ligatures
have not.

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
