" Vim filetype plugin for folding
" Language:              C
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

setlocal foldmethod=syntax

let b:undo_ftplugin .= 'setlocal foldmethod<'
