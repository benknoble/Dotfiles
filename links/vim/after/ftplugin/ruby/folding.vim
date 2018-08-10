" Vim filetype plugin for folding
" Language:              Ruby
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

let ruby_fold = 1

if !exists("*MyRubyFoldFtpluginUndo")
  function MyRubyFoldFtpluginUndo()
    unlet! ruby_fold
  endfunction
endif

let b:undo_ftplugin .= 'call MyRubyFoldFtpluginUndo()'
