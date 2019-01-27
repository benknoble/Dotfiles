function! make#quote_line(character) abort
  call make#remove_quotes()
  execute printf('normal! I%s', a:character)
endfunction

function! make#silence_errors() abort
  call make#quote_line('-')
endfunction

function! make#silence_execution() abort
  call make#quote_line('@')
endfunction

function! make#remove_quotes() abort
  silent! keeppatterns substitute/\m^\t\zs[+-@]//
endfunction
