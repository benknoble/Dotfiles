" Vim filetype plugin
" Language:              Makefile
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

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
nnoremap <silent> <buffer> <LocalLeader>+ :call make#quote_line('+')<CR>
xnoremap <silent> <buffer> <LocalLeader>+ :call make#quote_line('+')<CR>

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'shiftwidth',
      \ ],
      \ 'maps': [
      \   [ 'n', '<LocalLeader>-' ],
      \   [ 'x', '<LocalLeader>-' ],
      \   [ 'n', '<LocalLeader>2' ],
      \   [ 'x', '<LocalLeader>2' ],
      \   [ 'n', '<LocalLeader>@' ],
      \   [ 'x', '<LocalLeader>@' ],
      \   [ 'n', '<LocalLeader><Space>' ],
      \   [ 'x', '<LocalLeader><Space>' ],
      \   [ 'n', '<LocalLeader>+' ],
      \   [ 'x', '<LocalLeader>+' ],
      \ ],
      \ })
