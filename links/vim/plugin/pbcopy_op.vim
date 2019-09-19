if exists('g:loaded_pbcopy_op')
  finish
endif
let g:loaded_pbcopy_op = 1

nnoremap <silent> <C-y> :set operatorfunc=pbcopy#operator<CR>g@
vnoremap <silent> <C-y> :<C-u>call pbcopy#operator(visualmode(), 1)<CR>
