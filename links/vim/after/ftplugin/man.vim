" Vim filetype plugin
" Language:              Man
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" Don't show fancy whitespace
setlocal nolist
" No colorcolumn
setlocal colorcolumn=

" Line numbers
setlocal nonumber norelativenumber

" Search for options
" Use very magic to make patterns easy, and case sensitive because -b != -B
nnoremap <buffer> - /^\C\v\s*-
nnoremap <buffer> _ /^\C\v\s*--

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'list',
      \   'colorcolumn',
      \   'number',
      \   'relativenumber',
      \ ],
      \ 'maps': [
      \   [ 'n', '-' ],
      \   [ 'n', '_' ],
      \ ],
      \ })
