" Vim filetype plugin
" Language:              Help
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" Spell check off, by default
setlocal nospell

" Use :help for K in help docs
setlocal keywordprg=:help

setlocal colorcolumn=

nnoremap <buffer> q :quit<CR>

nnoremap <buffer> <CR> <C-]>

nnoremap <buffer> <C-n> :call bk#help#goto_link('next')<CR>
nnoremap <buffer> <C-p> :call bk#help#goto_link('prev')<CR>

let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ opts: [
      \   'keywordprg',
      \   'colorcolumn',
      \ ],
      \ maps: [
      \   [ 'n', 'q' ],
      \   [ 'n', '<CR>' ],
      \   [ 'n', '<C-n>' ],
      \   [ 'n', '<C-p>' ],
      \ ],
      \ })
