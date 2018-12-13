" Functions for finding things

" Makes [I nicer to navigate
function! find#included_word() abort
  normal! [I
  call inputsave()
  let l:nr = str2nr(input("Number: "))
  call inputrestore()
  " [I starts with the number 1
  " and a blank string (<CR> or <Esc>) is 0
  if l:nr <=# 0
    return
  else
    exec printf("normal! %d[\t", l:nr)
  endif
endfunction

