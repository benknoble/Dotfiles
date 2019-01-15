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

nnoremap <silent> <buffer> <LocalLeader>- :call make#silence_errors()<CR>
xnoremap <silent> <buffer> <LocalLeader>- :call make#silence_errors()<CR>
nnoremap <silent> <buffer> <LocalLeader>2 :call make#silence_execution()<CR>
xnoremap <silent> <buffer> <LocalLeader>2 :call make#silence_execution()<CR>
nnoremap <silent> <buffer> <LocalLeader>@ :call make#silence_execution()<CR>
xnoremap <silent> <buffer> <LocalLeader>@ :call make#silence_execution()<CR>
nnoremap <silent> <buffer> <LocalLeader><Space> :call make#remove_quotes()<CR>
xnoremap <silent> <buffer> <LocalLeader><Space> :call make#remove_quotes()<CR>

if !exists("*MyMakeFtpluginUndo")
  function MyMakeFtpluginUndo()
    setlocal shiftwidth<
    silent! nunmap <buffer> <LocalLeader>-
    silent! xunmap <buffer> <LocalLeader>-
    silent! nunmap <buffer> <LocalLeader>2
    silent! xunmap <buffer> <LocalLeader>2
    silent! nunmap <buffer> <LocalLeader>@
    silent! xunmap <buffer> <LocalLeader>@
    silent! nunmap <buffer> <LocalLeader><Space>
    silent! xunmap <buffer> <LocalLeader><Space>
  endfunction
endif

let b:undo_ftplugin .= 'call MyMakeFtpluginUndo()'
