if exists('g:loaded_subs')
  finish
endif
let g:loaded_subs = 1

" Make & substitute with previous flags as well
nnoremap & :&&<CR>
" Visual mode
xnoremap & :&&<CR>
