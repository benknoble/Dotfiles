" Vim filetype plugin for folding
" Language:              C
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

setlocal foldmethod=syntax

if !exists("*MyCFoldFtpluginUndo")
  function MyCFoldFtpluginUndo()
    setlocal foldmethod<
  endfunction
endif

let b:undo_ftplugin .= 'call MyCFoldFtpluginUndo()'
