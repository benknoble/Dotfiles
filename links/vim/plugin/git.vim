vim9script

if exists('g:loaded_bk_git')
  finish
endif
g:loaded_bk_git = 1

import autoload 'bk/git.vim'

command -bar GOpenCurrentContext git.OpenCurrentQuickfixContextFiles()
