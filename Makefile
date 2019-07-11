# Customize for installation {{{

BREWFILE = brew/Brewfile
REQUIREMENTS = requirements.txt
XDG_CONFIG_HOME = $(HOME)/.config
# supported features:
# git_extras
# brew_install
# pip
# none
FEATURES = git_extras brew_install pip

# }}}

# Make stuff {{{

# ensure sh
SHELL = /bin/sh
# clear out suffixes
.SUFFIXES:

# }}}

# Targets (Rules & Recipes) {{{

# default: print help about targets
default:
	@grep -E '^# .+: .+' Makefile | tr -d '#' | tr ':' '\t'

#  links {{{
LINKS = links
SYMLINKS = \
$(HOME)/.ackrc \
$(HOME)/.bash \
$(HOME)/.bash_profile \
$(HOME)/.bashrc \
$(HOME)/.bin \
$(HOME)/.ctags.d \
$(HOME)/.git_template \
$(HOME)/.gitconfig \
$(HOME)/.gitignore_global \
$(HOME)/.gitshrc \
$(HOME)/.inputrc \
$(HOME)/.jupyter \
$(HOME)/.pythonrc \
$(HOME)/.tmplr \
$(HOME)/.tmux.conf \
$(HOME)/.vim \


$(HOME)/.ackrc: $(LINKS)/ackrc
$(HOME)/.bash: $(LINKS)/bash
$(HOME)/.bash_profile: $(LINKS)/bash_profile
$(HOME)/.bashrc: $(LINKS)/bashrc
$(HOME)/.bin: $(LINKS)/bin
$(HOME)/.ctags.d: $(LINKS)/ctags.d
$(HOME)/.git_template: $(LINKS)/git_template
$(HOME)/.gitconfig: $(LINKS)/gitconfig
$(HOME)/.gitignore_global: $(LINKS)/gitignore_global
$(HOME)/.gitshrc: $(LINKS)/gitshrc
$(HOME)/.inputrc: $(LINKS)/inputrc
$(HOME)/.jupyter: $(LINKS)/jupyter
$(HOME)/.pythonrc: $(LINKS)/pythonrc
$(HOME)/.tmplr: $(LINKS)/tmplr
$(HOME)/.tmux.conf: $(LINKS)/tmux.conf
$(HOME)/.vim: $(LINKS)/vim
#  links }}}

# install: bootstrap the dotfiles
install: symlink $(FEATURES)

# update: update the dotfiles
update: pull_master update_submodules symlink brew_check vimtags pip

# symlink: ensure symlinks created
symlink: $(SYMLINKS)

# vimtags: regenerate tags for vim helpfiles
vimtags:
	vim +':helptags ALL' +'q'

# brewfile: update the brewfile
brewfile:
	brew bundle dump --force --file="$(BREWFILE)"

# submodules: fixup any issues with submodules
submodules:
	git submodule sync
	git submodule update --init
	git clean -ffd links/vim/pack/

$(SYMLINKS):
	 if test -e $@ ; then rm -rf $@ ; fi
	 ln -s $$(realpath $?) $@
	 @echo $@ '->' $$(realpath $?)

none:
	@:

USER_GITK = $(XDG_CONFIG_HOME)/git/gitk
DRACULA_GITK = Dracula/gitk/gitk

git_extras: gitk

gitk:
	[ -r "$(DRACULA_GITK)" ]
	mkdir -p "$$(dirname $(USER_GITK))"
	cp -iv -- "$(DRACULA_GITK)" "$(USER_GITK)"

BREW_URL = https://raw.githubusercontent.com/Homebrew/install/master/install

brew_install:
	/usr/bin/ruby -e "$$( curl -fsSL $(BREW_URL) )"
	brew tap Homebrew/bundle
	brew bundle install --file="$(BREWFILE)"
	sudo sh -c "echo $$(brew --prefix)/bin/bash >> /etc/shells"
	chsh -s "$$(brew --prefix)/bin/bash" "$$USER"

pip: $(REQUIREMENTS)
	python3 -m pip install --user --requirement $(REQUIREMENTS)

pull_master:
	git checkout master
	git pull --recurse-submodules=on-demand origin master

update_submodules:
	git submodule sync
	git submodule update

brew_check: $(BREWFILE)
	-brew bundle check --file="$(BREWFILE)"

# }}}
