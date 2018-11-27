# Vars {{{

# Customize for installation {{{

DOTFILES := ~/Dotfiles
BACKUP := $(DOTFILES)_old
SETUP := $(DOTFILES)/setup

# }}}

# Make conventions {{{

# ensure sh
SHELL := /bin/sh
# clear out suffixes
.SUFFIXES:

# }}}

# }}}

# Macros (Functions & Canned Recipes) {{{

define yes_or_no
read -n 1 -p "[y/n]> " input && echo && [[ "$$input" =~ ^(y|Y) ]]
endef

define msg
printf '%s\n'
endef

# }}}

# Targets (Rules & Recipes) {{{

# default: print help about targets
.PHONY: default
default:
	@grep -E '# \w+: .+' Makefile | tr -d '#' | tr ':' '\t'

# install: bootstrap the dotfiles
.PHONY: install
.PHONY: all
all: install
install:
	@$(MAKE) bootstrap

# update: update the dotfiles
.PHONY: update
update:
	./update.sh

# vimtags: regenerate tags for vim helpfiles
.PHONY: vimtags
vimtags:
	vim +':helptags ALL' +'q'

# Helper targets {{{

.PHONY: bootstrap
bootstrap:
	@$(msg) 'WARNING: Backups in the old directory ($(BACKUP))'
	@$(msg) 'will be DELETED and OVERWRITTEN!'
	@$(msg) 'If you want to keep them, abort and move them!'
	@$(msg) 'Are you sure you want to continue bootstrapping Dotfiles?'
	@if $(yes_or_no) ; then\
		$(MAKE) bootstrap_full;\
	else\
		$(msg) 'Aborting';\
	fi

.PHONY: bootstrap_full
bootstrap_full:
	@$(MAKE) symlink
	@$(MAKE) installers

.PHONY: symlink
symlink:
	@$(msg) 'Symlinking dotfiles...'
	@$(SETUP)/makesymlinks.sh
	@$(msg) '...done with symlinks'

.PHONY: installers
installers:
	@$(msg) 'Running installers...'
	@$(SETUP)/install-all.sh
	@$(msg) '...done with installers'

# }}}

# }}}
