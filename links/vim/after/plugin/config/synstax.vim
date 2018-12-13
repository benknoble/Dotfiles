if ! exists('*synstax#UnderCursor')
  finish
endif

nnoremap <unique> <Leader><Leader>s :echo synstax#UnderCursor()<CR>
