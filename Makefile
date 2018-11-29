# Vars {{{

# Customize for installation {{{

DOTFILES ?= ~/Dotfiles
BACKUP ?= $(DOTFILES)_old
SETUP := $(DOTFILES)/setup
SUPPORT := $(SETUP)/support
BREWFILE ?= $(if $(shell [ -e ~/.Brewfile ] && echo true),~/.Brewfile,$(DOTFILES)/brew/Brewfile)
XDG_CONFIG_HOME ?= ~/.config
# supported features:
# git_extras
# brew
FEATURES ?= git_extras brew

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

define yes_or_no
read -n 1 -p "[y/n]> " input && echo && [[ "$$input" =~ ^(y|Y) ]]
endef

define msg
printf '%s\n'
endef

define run_installer
$(msg) 'Install $@?'
if $(yes_or_no) ; then\
	@$(MAKE) _$@;\
else\
	$(msg) "Skipping $@";\
fi
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
	@$(MAKE) _features

.PHONY: _symlink
_symlink:
	@$(msg) 'Symlinking dotfiles...'
	@$(SETUP)/makesymlinks.sh
	@$(msg) '...done with symlinks'

.PHONY: _features
_features:
	@$(msg) 'Running features...'
	@$(MAKE) $(FEATURES)
	@$(msg) '...done with features'

# Features {{{

.PHONY: $(FEATURES)
$(FEATURES):
	@$(run_installer)

# Git extras {{{

USER_GITK := $(XDG_CONFIG_HOME)/git/gitk
DRACULA_GITK := $(DOTFILES)/Dracula/gitk/gitk

.PHONY: _git_extras
_git_extras:
	@$(msg) 'Install git extras...'
	@$(MAKE) _gitk
	@$(msg) '...done with git extras'

.PHONY: _gitk
_gitk:
	@$(msg) 'Copying gitk dracula theme...'
	@if [ -r "$(DRACULA_GITK)" ]; then\
		mkdir -p "$(dir USER_GITK)";\
		cp -iv -- "$(DRACULA_GITK)" "$(USER_GITK)";\
		$(msg) '...done with gitk dracula theme';\
	else\
		$(msg) '...no dracula gitk found';\
	fi

# }}}

# Brew {{{

BREW_URL := https://raw.githubusercontent.com/Homebrew/install/master/install

.PHONY: _brew
_brew:
	@$(msg) 'Installing brew...'
	@/usr/bin/ruby -e "$$( curl -fsSL $(BREW_URL) )"
	@$(MAKE) _bundle
	sudo sh -c "echo $$(brew --prefix)/bin/bash >> /etc/shells"\
		&& chsh -s "$$(brew --prefix)/bin/bash" "$$USER"
	@$(msg) '...done with brew'

.PHONY: _bundle
_bundle:
	brew tap Homebrew/bundle
	brew bundle install --file="$(BREWFILE)"

# }}}

# }}}

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
