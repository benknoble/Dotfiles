" Vim filetype plugin
" Language:              Python
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

let python_highlight_all = 1
let b:interpreter = 'python'

setlocal textwidth=79

nnoremap <buffer> <LocalLeader>t :term python setup.py test -q<CR>

if !exists("*MyPythonFtpluginUndo")
  function MyPythonFtpluginUndo()
    setlocal textwidth<

    unlet! python_highlight_all
    unlet! b:interpreter

    silent! nunmap <buffer> <LocalLeader>t
  endfunction
endif

let b:undo_ftplugin .= 'call MyPythonFtpluginUndo()'
