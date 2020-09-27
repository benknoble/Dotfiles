function! bk#grep#operator(type) abort
  let s:saved_unnamed_register = @@

  if a:type ==# 'v'
    execute "normal! `<v`>y"
  elseif a:type ==# 'char'
    execute "normal! `[v`]y"
  else
    return
  endif

  silent execute printf("grep! -R %s .", shellescape(@@))
  redraw!
  copen

  let @@ = s:saved_unnamed_register
  unlet s:saved_unnamed_register
endfunction
