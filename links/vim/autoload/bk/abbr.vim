function bk#abbr#not_comment(original, replacement) abort
  return bk#syntax#is_comment() ? a:original : a:replacement
endfunction
