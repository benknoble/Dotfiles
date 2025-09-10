function bk#wiki#commit() abort
  if empty(bufname()) | return | endif
  call feedkeys(":Git commit %\<enter>")
endfunction
