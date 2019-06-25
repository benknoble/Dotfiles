" true iff p1 is before p2 in the buffer
" a pos is [lnum, col]
function! pos#before(p1, p2) abort
  return a:p1[0] < a:p2[0] || (a:p1[0] == a:p2[0] && a:p1[1] <= a:p2[1])
endfunction
