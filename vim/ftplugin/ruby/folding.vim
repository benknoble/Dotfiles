" Vim filetype plugin for folding
" Language:              Ruby
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

let ruby_fold = 1

let b:undo_ftplugin .= 'unlet ruby_fold'
