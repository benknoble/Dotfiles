if exists('g:loaded_windows')
  finish
endif
let g:loaded_windows = 1

nnoremap <Up> <C-w>k
nnoremap <S-Up> <C-w>K
nnoremap <Down> <C-w>j
nnoremap <S-Down> <C-w>J
nnoremap <Left> <C-w>h
nnoremap <S-Left> <C-w>H
nnoremap <Right> <C-w>l
nnoremap <S-Right> <C-w>L

" Open help files at height lines - 10
let &helpheight = (&lines - 10)
" Don't equalize window sizes automatically
set noequalalways
" Diff vertically
set diffopt+=vertical

" Make buffers hidden when unloaded, just in case you want them back
set hidden
