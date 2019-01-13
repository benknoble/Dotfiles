if exists('g:clear_trailing_whitespace')
  finish
endif
let g:clear_trailing_whitespace = 1

function s:clear_trailing_whitespace() abort
  keeppatterns %substitute/\m\s\+$//e
endfunction

command -bar ClearTrailingWhitespace call <SID>clear_trailing_whitespace()
