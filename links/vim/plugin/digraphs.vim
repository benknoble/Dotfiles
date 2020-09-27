if exists('g:loaded_digraphs')
  finish
endif
let g:loaded_digraphs = 1

command -bang Digraphs
      \ if empty('<bang>') |
      \   call bk#digraphs#activate() |
      \ else |
      \   call bk#digraphs#deactivate() |
      \ endif
