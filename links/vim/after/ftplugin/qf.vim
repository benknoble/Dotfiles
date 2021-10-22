" Vim filetype plugin
" Language:              Quickfix/Location list windows
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

nnoremap <buffer> q :quit<CR>

nnoremap <buffer> <C-n> :call bk#qf#NextFile()<CR>
nnoremap <buffer> <C-p> :call bk#qf#PreviousFile()<CR>

let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ maps: [
      \   [ 'n', 'q' ],
      \   [ 'n', '<C-n>' ],
      \   [ 'n', '<C-p>' ],
      \ ],
      \ })
