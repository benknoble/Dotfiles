if exists('g:loaded_Q')
  finish
endif
let g:loaded_Q = 1

" Don't use Ex mode, use Q for formatting
" Prefer gQ anyway
nnoremap Q gq
xnoremap Q gq
" Format the whole line
nnoremap QQ gqgq
