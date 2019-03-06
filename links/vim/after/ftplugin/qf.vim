" Vim filetype plugin
" Language:              Quickfix/Location list windows
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

nnoremap <buffer> <silent> q :q<CR>

nnoremap <buffer> <silent> <C-n> :call qf#NextFile()<CR>
nnoremap <buffer> <silent> <C-p> :call qf#PreviousFile()<CR>

let b:undo_ftplugin = ftplugin#undo({
      \ 'maps': [
      \   [ 'n', 'q' ],
      \   [ 'n', '<C-n>' ],
      \   [ 'n', '<C-p>' ],
      \ ],
      \ })
