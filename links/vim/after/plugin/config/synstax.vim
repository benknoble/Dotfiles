if ! (&rtp =~# 'synstax')
  finish
endif

call popsikey#extend(g:popsikey_info_id, [
      \ #{
      \   key: 's',
      \   info: 'syntax',
      \   action: ":echo synstax#UnderCursor()\<CR>",
      \ },
      \ ],
      \ #{})
