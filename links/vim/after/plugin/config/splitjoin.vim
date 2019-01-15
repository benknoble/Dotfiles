if ! exists(':SplitjoinSplit')
  finish
endif

" Turn off mapings, because I couldn't make them work with <Leader>
nunmap gS
nunmap gJ

nnoremap <Leader>J :SplitjoinJoin<CR>
nnoremap <Leader>S :SplitjoinSplit<CR>
