# Vars {{{

# ensure sh
SHELL := /bin/sh
# clear out suffixes
.SUFFIXES:

# }}}

# Targets (Rules & Recipes) {{{

# default: print help about targets
.PHONY: default
default:
	@grep -E '# \w+: .+' Makefile | tr -d '#' | tr ':' '\t'

# install: bootstrap the dotfiles
.PHONY: install
install:
	./bootstrap.sh

# update: update the dotfiles
.PHONY: update
update:
	./update.sh

# vimtags: regenerate tags for vim helpfiles
.PHONY: vimtags
vimtags:
	vim +':helptags ALL' +'q'

# }}}
