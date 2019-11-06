if exists('g:loaded_pbcopy_op')
  finish
endif
let g:loaded_pbcopy_op = 1

nnoremap <C-y> :set operatorfunc=pbcopy#operator<CR>g@
nnoremap <C-y>y :set operatorfunc=pbcopy#operator<CR>g@_
nnoremap <C-y><C-y> :set operatorfunc=pbcopy#operator<CR>g@_
vnoremap <C-y> :<C-u>call pbcopy#operator(visualmode(), 1)<CR>
