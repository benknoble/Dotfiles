function bk#wiki#commit() abort
  if empty(bufname()) | return | endif
  if &filetype =~# 'git' | return | endif
  call feedkeys(":Git commit %\<enter>")
endfunction
