if exists('g:loaded_digraphs')
  finish
endif
let g:loaded_digraphs = 1

command -bang Digraphs
      \ if empty('<bang>') |
      \   call digraphs#activate() |
      \ else |
      \   call digraphs#deactivate() |
      \ endif
