" Vim filetype plugin
" Language:              Man
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" Don't show fancy whitespace
setlocal nolist
" No colorcolumn
setlocal colorcolumn=

" Line numbers
setlocal nonumber norelativenumber

setlocal nofoldenable

" Search for options
" Use very magic to make patterns easy, and case sensitive because -b != -B
nnoremap <buffer> - /^\C\v\s*-
nnoremap <buffer> _ /^\C\v\s*(-[^,]*,\s*)?--(\[no-\])?

nnoremap <buffer> q :quit<enter>

let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ opts: [
      \   'list',
      \   'colorcolumn',
      \   'number',
      \   'relativenumber',
      \   'foldenable',
      \ ],
      \ maps: [
      \   [ 'n', '-' ],
      \   [ 'n', '_' ],
      \   [ 'n', 'q' ],
      \ ],
      \ })
