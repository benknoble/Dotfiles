# Vars {{{

# Customize for installation {{{

DOTFILES ?= ~/Dotfiles
BACKUP ?= $(DOTFILES)_old
SETUP := $(DOTFILES)/setup
BREWFILE ?= $(if $(shell [ -e ~/.Brewfile ] && echo true),~/.Brewfile,$(DOTFILES)/brew/Brewfile)

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

# Main {{{

# default: print help about targets
.PHONY: default
default:
	@grep -E '# \w+: .+' Makefile | tr -d '#' | tr ':' '\t'

# install: bootstrap the dotfiles
.PHONY: install
.PHONY: all
all: install
install:
	@$(MAKE) _bootstrap

# update: update the dotfiles
.PHONY: update
update:
	@$(MAKE) _update

# vimtags: regenerate tags for vim helpfiles
.PHONY: vimtags
vimtags:
	vim +':helptags ALL' +'q'

# }}}

# Helper targets {{{

# Bootstrap {{{

.PHONY: _bootstrap
_bootstrap:
	@$(msg) 'WARNING: Backups in the old directory ($(BACKUP))'
	@$(msg) 'will be DELETED and OVERWRITTEN!'
	@$(msg) 'If you want to keep them, abort and move them!'
	@$(msg) 'Are you sure you want to continue bootstrapping Dotfiles?'
	@if $(yes_or_no) ; then\
		$(MAKE) _bootstrap_full;\
	else\
		$(msg) 'Aborting';\
	fi

.PHONY: _bootstrap_full
_bootstrap_full:
	@$(MAKE) _symlink
	@$(MAKE) _installers

.PHONY: _symlink
_symlink:
	@$(msg) 'Symlinking dotfiles...'
	@$(SETUP)/makesymlinks.sh
	@$(msg) '...done with symlinks'

.PHONY: _installers
_installers:
	@$(msg) 'Running installers...'
	@$(SETUP)/install-all.sh
	@$(msg) '...done with installers'

# }}}

# Update {{{

.PHONY: _update
_update:
	@if $(MAKE) _pull_master && $(MAKE) _update_submodules ; then\
		$(MAKE) _brew_update;\
		$(msg) 'Updated';\
		$(msg) "Type 'reload' to reload updates";\
		$(msg) 'You may need to logout of the terminal and login for';\
		$(msg) 'changes to take full effect';\
	else\
		$(msg) 'Update failed';\
	fi

.PHONY: _pull_master
_pull_master:
	@cd $(DOTFILES) \
		&& git checkout master \
		&& git pull --recurse-submodules=on-demand origin master

.PHONY: _update_submodules
_update_submodules:
	@cd $(DOTFILES) \
		&& git submodule sync \
		&& git submodule update

.PHONY: _brew_update
_brew_update:
	@$(msg) 'Brewfile: $(BREWFILE)'
	@command -v brew >/dev/null 2>&1 \
		&& { brew bundle check --file="$(BREWFILE)" || true; }

# }}}

# }}}

# }}}
