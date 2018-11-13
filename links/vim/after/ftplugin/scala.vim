" Vim filetype plugin
" Language:              Scala
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

let b:interpreter = 'scala'

if !exists("*MyScalaFtpluginUndo")
  function MyScalaFtpluginUndo()

    unlet! b:interpreter

  endfunction
endif

let b:undo_ftplugin .= 'call MyScalaFtpluginUndo()'
