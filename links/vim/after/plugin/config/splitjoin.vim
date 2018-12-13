if ! exists(':SplitjoinSplit')
  finish
endif

" Turn off mapings, because I couldn't make them work with <Leader>
let g:splitjoin_split_mapping = ""
let g:splitjoin_join_mapping = ""
