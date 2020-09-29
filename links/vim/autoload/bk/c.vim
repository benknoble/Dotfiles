function bk#c#nopow() abort
  substitute/pow(\(\S\+\), \(\d\+\))/\=submatch(1).repeat(' * '.submatch(1), eval(submatch(2)-1))/g
endfunction
