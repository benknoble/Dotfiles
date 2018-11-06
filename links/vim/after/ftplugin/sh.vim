" Vim filetype plugin
" Language:              [ba]sh script
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

" Wrap at 80 characters
setlocal textwidth=80
" Indent two spaces
setlocal shiftwidth=2 softtabstop=2
" Fix keywords
setlocal iskeyword+=$

if !exists("*MyShFtpluginUndo")
  function MyShFtpluginUndo()
    setlocal textwidth<
    setlocal shiftwidth<
    setlocal softtabstop<
    setlocal iskeyword<
  endfunction
endif

let b:undo_ftplugin .= 'call MyShFtpluginUndo()'
