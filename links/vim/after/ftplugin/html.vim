" Vim filetype plugin
" Language:              HTML
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" Tab settings
setlocal shiftwidth=2 softtabstop=2

nnoremap <buffer> <LocalLeader>o :silent !open %<CR>:redraw!<CR>

let b:undo_ftplugin = bk#ftplugin#undo({
      \ 'opts': [
      \   'shiftwidth',
      \   'softtabstop',
      \ ],
      \ 'maps': [
      \   ['n', '<LocalLeader>o'],
      \ ],
      \ })
