" Vim filetype plugin
" Language:              Man
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

" Don't show fancy whitespace
setlocal nolist
" No colorcolumn
set colorcolumn=

if !exists("*MyManFtpluginUndo")
  function MyManFtpluginUndo()
    setlocal list<
    setlocal colorcolumn<
  endfunction
endif

let b:undo_ftplugin .= 'call MyManFtpluginUndo()'
