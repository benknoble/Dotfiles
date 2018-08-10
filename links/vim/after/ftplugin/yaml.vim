" Vim filetype plugin
" Language:              YAML
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

" Indent two spaces
setlocal shiftwidth=2 softtabstop=2

if !exists("*MyYamlFtpluginUndo")
  function MyYamlFtpluginUndo()
    setlocal shiftwidth<
    setlocal softtabstop<
  endfunction
endif

let b:undo_ftplugin .= 'call MyYamlFtpluginUndo()'
