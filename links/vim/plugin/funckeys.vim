if exists('g:loaded_funkeys')
  finish
endif
let g:loaded_funkeys = 1

" <F1> is help

" Not technically a mapping, but acts like one
" Toggle paste mode during an insert with <F7>
set pastetoggle=<F7>

" <F8> to spawn a terminal
nnoremap <F8> :terminal<CR>

" Panic button
nnoremap <F9> mzggg?G`z
