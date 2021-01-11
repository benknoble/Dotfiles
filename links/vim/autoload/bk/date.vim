function bk#date#month2num(month) abort
  return split('jan feb mar apr may jun jul aug sep oct nov dec')
        \ ->index(tolower(a:month))
        \ + 1
endfunction
