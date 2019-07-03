if ! exists(':Goyo')
  finish
endif

let g:goyo_width = &textwidth + 10

nnoremap <Leader><Leader>g :Goyo<CR>
