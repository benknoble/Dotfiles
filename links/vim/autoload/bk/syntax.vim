function bk#syntax#is_comment() abort
  let syntax = synstax#UnderCursor()
  return type(syntax) is# v:t_list
        \ && reduce(syntax, {acc, val -> acc || val =~# 'Comment'}, v:false)
endfunction
