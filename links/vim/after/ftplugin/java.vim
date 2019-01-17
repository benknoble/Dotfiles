" Vim filetype plugin
" Language:              Java
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

let b:interpreter = 'bash -c "make jdb || jdb"'

if !exists("*MyJavaFtpluginUndo")
  function MyJavaFtpluginUndo()
    unlet! b:interpreter
  endfunction
endif

let b:undo_ftplugin .= 'call MyJavaFtpluginUndo()'
