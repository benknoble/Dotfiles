" Vim filetype plugin
" Language:              Quickfix/Location list windows
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

nnoremap <buffer> <silent> q :q<CR>

nnoremap <buffer> <silent> <C-n> :call qf#NextFile()<CR>
nnoremap <buffer> <silent> <C-p> :call qf#PreviousFile()<CR>

if !exists("*MyQfFtpluginUndo")
  function MyQfFtpluginUndo()
    silent! nunmap <buffer> q
    silent! nunmap <buffer> <C-n>
    silent! nunmap <buffer> <C-p>
  endfunction
endif

let b:undo_ftplugin .= 'call MyQfFtpluginUndo()'
