if exists('g:loaded_pbcopy_op')
  finish
endif
let g:loaded_pbcopy_op = 1

nnoremap <silent> <C-y> :set operatorfunc=pbcopy#operator<CR>g@
nnoremap <silent> <C-y>y :set operatorfunc=pbcopy#operator<CR>g@_
nnoremap <silent> <C-y><C-y> :set operatorfunc=pbcopy#operator<CR>g@_
vnoremap <silent> <C-y> :<C-u>call pbcopy#operator(visualmode(), 1)<CR>
