" Vim filetype plugin
" Language:              Makefile
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

" Tabs are 8 wide
setlocal shiftwidth=8

if !exists("*MyMakeFtpluginUndo")
  function MyMakeFtpluginUndo()
    setlocal shiftwidth<
  endfunction
endif

let b:undo_ftplugin .= 'call MyMakeFtpluginUndo()'
