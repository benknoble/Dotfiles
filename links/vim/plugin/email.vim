if exists('g:loaded_emailcommand')
  finish
endif
let g:loaded_emailcommand = 1

command Email let old_textwidth = &l:textwidth
      \ | setlocal textwidth=9999
      \ | execute 'normal! gggqG'
      \ | let &l:textwidth = old_textwidth
      \ | unlet old_textwidth
