function bk#coq#get_def(word, type) abort
  execute 'Coq' a:type a:word
  sleep 100m
  call coqtail#panels#switch(g:coqtail#panels#info)
  0
  0;'}-yank
  call coqtail#panels#switch(g:coqtail#panels#main)
  setlocal modifiable
  put
  '[,']Commentary
  redraw!
endfunction
