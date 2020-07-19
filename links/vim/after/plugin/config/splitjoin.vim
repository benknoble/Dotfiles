if ! exists(':SplitjoinSplit')
  finish
endif

" Turn off mapings, because I couldn't make them work with <Leader>
nunmap gS
nunmap gJ

call popsikey#register('<Leader>j', [
      \ #{ key: 'j', info: 'join', action: ":SplitjoinJoin\<CR>", },
      \ #{ key: 's', info: 'split', action: ":SplitjoinSplit\<CR>", },
      \ ],
      \ #{
      \ title: ' Splitjoin ',
      \ })
