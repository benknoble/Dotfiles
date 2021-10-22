" Vim filetype plugin
" Language:              Makefile
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" Tabs are 8 wide
setlocal shiftwidth=8

nnoremap <buffer> <LocalLeader>- :call bk#make#silence_errors()<CR>
xnoremap <buffer> <LocalLeader>- :call bk#make#silence_errors()<CR>
nnoremap <buffer> <LocalLeader>2 :call bk#make#silence_execution()<CR>
xnoremap <buffer> <LocalLeader>2 :call bk#make#silence_execution()<CR>
nnoremap <buffer> <LocalLeader>@ :call bk#make#silence_execution()<CR>
xnoremap <buffer> <LocalLeader>@ :call bk#make#silence_execution()<CR>
nnoremap <buffer> <LocalLeader><Space> :call bk#make#remove_quotes()<CR>
xnoremap <buffer> <LocalLeader><Space> :call bk#make#remove_quotes()<CR>
nnoremap <buffer> <LocalLeader>+ :call bk#make#quote_line('+')<CR>
xnoremap <buffer> <LocalLeader>+ :call bk#make#quote_line('+')<CR>

let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ opts: [
      \   'shiftwidth',
      \ ],
      \ maps: [
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
