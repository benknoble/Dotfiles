if ! &rtp =~# 'synstax'
  finish
endif

nnoremap <unique> <Leader><Leader>s :echo synstax#UnderCursor()<CR>
