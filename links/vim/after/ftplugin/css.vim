" Vim filetype plugin
" Language:              CSS
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

" Tab settings
setlocal shiftwidth=2 softtabstop=2

if !exists("*MyCSSFtpluginUndo")
  function MyCSSFtpluginUndo()
    setlocal shiftwidth<
    setlocal softtabstop<
  endfunction
endif

let b:undo_ftplugin .= 'call MyCSSFtpluginUndo()'
