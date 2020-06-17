" Functions for finding things

" Makes [I nicer to navigate
function! find#included_word(word) abort
  execute 'ilist' a:word
  call feedkeys(':ijump  '.a:word."\<S-Left>\<Left>", 'n')
endfunction

function! find#macrod_word(word) abort
  execute 'dlist' a:word
  call feedkeys(':djump  '.a:word."\<S-Left>\<Left>", 'n')
endfunction
