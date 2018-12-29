" Vim filetype plugin
" Language:              Vim script
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

" Indent two spaces
setlocal shiftwidth=2 softtabstop=2

" Use :help for K in vimscript
setlocal keywordprg=:help

" Execute the current line
nnoremap <silent> <buffer> <LocalLeader>el :execute getline('.')<CR>

if !exists("*MyVimFtpluginUndo")
  function MyVimFtpluginUndo()
    setlocal shiftwidth<
    setlocal softtabstop<
    setlocal keywordprg<
    silent! nunmap <buffer> <LocalLeader>el
  endfunction
endif

let b:undo_ftplugin .= 'call MyVimFtpluginUndo()'
