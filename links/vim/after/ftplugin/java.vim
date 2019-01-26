" Vim filetype plugin
" Language:              Java
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

" Indent two spaces
setlocal shiftwidth=2 softtabstop=2

let b:interpreter = 'bash -c "make jdb || jdb"'

if !exists("*MyJavaFtpluginUndo")
  function MyJavaFtpluginUndo()
    setlocal shiftwidth< softtabstop<
    unlet! b:interpreter
  endfunction
endif

let b:undo_ftplugin .= 'call MyJavaFtpluginUndo()'
