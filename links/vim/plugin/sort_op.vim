if exists('g:loaded_sort_op')
  finish
endif
let g:loaded_sort_op = 1

nnoremap <silent> gs :set operatorfunc=sort#operator<CR>g@
vnoremap <silent> gs :<C-u>call sort#operator(visualmode(), 1)<CR>
