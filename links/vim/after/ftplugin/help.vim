" Vim filetype plugin
" Language:              Help
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

" Spell check off, by default
setlocal nospell

" Use :help for K in help docs
setlocal keywordprg=:help

let b:undo_ftplugin .= 'setlocal spell< keywordprg<'
