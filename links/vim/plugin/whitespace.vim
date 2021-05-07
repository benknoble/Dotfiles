if exists('g:trim_trailing_whitespace')
  finish
endif
let g:trim_trailing_whitespace = 1

function s:trim_trailing_whitespace() abort
  keeppatterns %substitute/\m\s\+$//e
endfunction

command -bar TrimTrailingWhitespace call <SID>trim_trailing_whitespace()

command -bar OnlySpaces keeppatterns %substitute/[‏‎‌‍ ]//ge
