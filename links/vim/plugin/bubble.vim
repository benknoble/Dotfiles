if exists('g:loaded_bubble')
  finish
endif
let g:loaded_bubble = 1

" Bubble single lines up and down
nnoremap - :.move +1<CR>
nnoremap _ :.move -2<CR>
" Bubble lines up and down in visual mode
vnoremap - :'<,'>move '>+1 \| normal! gv<CR>
vnoremap _ :'<,'>move '<-2 \| normal! gv<CR>
