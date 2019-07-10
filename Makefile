# TODO make posix
# Vars {{{

# Customize for installation {{{

DOTFILES ?= $(HOME)/Dotfiles
BACKUP ?= $(DOTFILES)_old
SETUP := $(DOTFILES)/setup
SUPPORT := $(SETUP)/support
BREWFILE ?= $(if $(shell [ -e $(HOME)/.Brewfile ] && echo true),$(HOME)/.Brewfile,$(DOTFILES)/brew/Brewfile)
REQUIREMENTS ?= $(DOTFILES)/requirements.txt
XDG_CONFIG_HOME ?= $(HOME)/.config
# supported features:
# git_extras
# brew
# pip
# none
FEATURES ?= git_extras brew pip

# }}}

# Make conventions {{{

# ensure sh
SHELL := /bin/sh
# clear out suffixes
.SUFFIXES:

# export vars
export
# }}}

# }}}

# Macros (Functions & Canned Recipes) {{{
# }}}

# Targets (Rules & Recipes) {{{

# Main {{{

# default: print help about targets
.PHONY: default
default:
	@grep -E '# \w+: .+' Makefile | tr -d '#' | tr ':' '\t'

# install: bootstrap the dotfiles
.PHONY: install
.PHONY: all
all: install
install: symlink $(patsubst %,_%,$(FEATURES))

# update: update the dotfiles
.PHONY: update
update: _pull_master _update_submodules _brew_update vimtags

# symlink: re-create the symlinks
.PHONY: symlink
symlink:
	$(SETUP)/makesymlinks.sh

# vimtags: regenerate tags for vim helpfiles
.PHONY: vimtags
vimtags:
	vim +':helptags ALL' +'q'

# brewfile: update the appropriate brewfile
.PHONY: brewfile
brewfile:
	brew bundle dump --force --file="$(BREWFILE)"

# submodules: fixup any issues with submodules
.PHONY: submodules
submodules:
	git submodule sync
	git submodule update --init
	git clean -ffd links/vim/pack/

# }}}

# Helper targets {{{

_none:
	@:

# Git extras {{{

USER_GITK := $(XDG_CONFIG_HOME)/git/gitk
DRACULA_GITK := $(DOTFILES)/Dracula/gitk/gitk

.PHONY: _git_extras
_git_extras: _gitk

.PHONY: _gitk
_gitk:
	[ -r "$(DRACULA_GITK)" ]
	mkdir -p "$(dir $(USER_GITK))"
	cp -iv -- "$(DRACULA_GITK)" "$(USER_GITK)"

# }}}

# Brew {{{

BREW_URL := https://raw.githubusercontent.com/Homebrew/install/master/install

.PHONY: _brew
_brew:
	/usr/bin/ruby -e "$$( curl -fsSL $(BREW_URL) )"
	brew tap Homebrew/bundle
	brew bundle install --file="$(BREWFILE)"
	sudo sh -c "echo $$(brew --prefix)/bin/bash >> /etc/shells"
	chsh -s "$$(brew --prefix)/bin/bash" "$$USER"

# }}}

#  Pip {{{
.PHONY: _pip
_pip:
	python3 -m pip install --user --requirement $(REQUIREMENTS)
#  Pip }}}

# Update {{{

.PHONY: _pull_master
_pull_master:
	git -C $(DOTFILES) checkout master
	git -C $(DOTFILES) pull --recurse-submodules=on-demand origin master

.PHONY: _update_submodules
_update_submodules:
	git -C $(DOTFILES) submodule sync
	git -C $(DOTFILES) submodule update

.PHONY: _brew_update
_brew_update:
	-brew bundle check --file="$(BREWFILE)"

# }}}

# }}}

# }}}
