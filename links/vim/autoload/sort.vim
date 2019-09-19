function! sort#operator(type, ...) abort

  let l:visual = a:0

  if l:visual
    '<,'>sort
  else
    '[,']sort
  endif

endfunction
