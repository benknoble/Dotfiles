" Vim filetype plugin
" Language:              Man
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" Don't show fancy whitespace
setlocal nolist
" No colorcolumn
setlocal colorcolumn=

" Line numbers
setlocal nonumber norelativenumber

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'list',
      \   'colorcolumn',
      \   'number',
      \   'relativenumber',
      \ ],
      \ })
