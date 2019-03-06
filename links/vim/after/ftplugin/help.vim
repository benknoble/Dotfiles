" Vim filetype plugin
" Language:              Help
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" Spell check off, by default
setlocal nospell

" Use :help for K in help docs
setlocal keywordprg=:help

setlocal colorcolumn=

nnoremap <silent> <buffer> q :q<CR>

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'keywordprg',
      \   'colorcolumn',
      \ ],
      \ 'maps': [
      \   [ 'n', 'q' ],
      \ ],
      \ })
