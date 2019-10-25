if exists('g:loaded_hex')
  finish
endif
let g:loaded_hex = 1

command -bar -bang Hex
      \ if <bang>0 |
      \   set filetype= |
      \   edit! |
      \ else |
      \   set filetype=xxd |
      \ endif
command -bar Bless Hex!
