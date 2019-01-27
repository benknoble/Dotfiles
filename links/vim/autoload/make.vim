function! make#quote_line(character) abort
  execute printf('normal! I%s', a:character)
endfunction

function! make#silence_errors() abort
  call make#quote_line('-')
endfunction

function! make#silence_execution() abort
  call make#quote_line('@')
endfunction

function! make#remove_quotes() abort
  silent! keeppatterns substitute/\m^\s*\zs[-@]//
endfunction
