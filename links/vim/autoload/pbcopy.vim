function! pbcopy#operator(type, ...) abort

  let l:visual = a:0

  if l:visual
    normal! gv"*y
  elseif a:type == 'line'
    '[,']yank *
  else " char
    normal! `[v`]"*y
  endif

endfunction
