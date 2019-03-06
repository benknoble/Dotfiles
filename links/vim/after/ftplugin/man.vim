" Vim filetype plugin
" Language:              Man
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" Don't show fancy whitespace
setlocal nolist
" No colorcolumn
set colorcolumn=

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'list',
      \   'colorcolumn',
      \ ],
      \ })
