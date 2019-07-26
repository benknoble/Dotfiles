if exists('g:loaded_digraphs')
  finish
endif
let g:loaded_digraphs = 1

inoremap <silent> <C-d> <C-o>:call digraphs#activate()<CR>
