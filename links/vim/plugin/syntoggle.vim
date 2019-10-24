if exists('g:loaded_syntoggle')
  finish
endif
let g:loaded_syntoggle = 1

command SynToggle
      \ if exists("g:syntax_on") |
      \   syntax off |
      \ else |
      \   syntax enable |
      \ endif
