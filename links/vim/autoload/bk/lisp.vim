function bk#lisp#at_start_of_form() abort
  return getline('.')[col('.') - 2] == '('
endfunction
