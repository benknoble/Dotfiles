" Vim filetype plugin
" Language:              Help
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" Spell check off, by default
setlocal nospell

" Use :help for K in help docs
setlocal keywordprg=:help

setlocal colorcolumn=

nnoremap <silent> <buffer> q :q<CR>

nnoremap <silent> <buffer> <CR> <C-]>

nnoremap <silent> <buffer> <C-n> :call help#goto_link('next')<CR>
nnoremap <silent> <buffer> <C-p> :call help#goto_link('prev')<CR>

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'keywordprg',
      \   'colorcolumn',
      \ ],
      \ 'maps': [
      \   [ 'n', 'q' ],
      \   [ 'n', '<CR>' ],
      \   [ 'n', '<C-n>' ],
      \   [ 'n', '<C-p>' ],
      \ ],
      \ })
