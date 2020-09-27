function! bk#make#quote_line(character) abort
  call bk#make#remove_quotes()
  execute printf('normal! I%s', a:character)
endfunction

function! bk#make#silence_errors() abort
  call bk#make#quote_line('-')
endfunction

function! bk#make#silence_execution() abort
  call bk#make#quote_line('@')
endfunction

function! bk#make#remove_quotes() abort
  silent! keeppatterns substitute/\m^\t\zs[+-@]//
endfunction
