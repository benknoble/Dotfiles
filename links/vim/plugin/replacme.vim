if exists('g:loaded_replaceme')
  finish
endif
let g:loaded_replaceme = 1

" based on https://vi.stackexchange.com/a/34561/10604
function ReplaceMe(startline, endline, toreplace, firstreplacement, ...) abort
  let template = join(getline(a:startline, a:endline), "\n")
  execute a:startline . ',' . a:endline . 'd _'
  " put! first time to so we don't move down a line the first time
  put! =substitute(template, a:toreplace, a:firstreplacement, 'g')
  for replacement in a:000
    put =substitute(template, a:toreplace, replacement, 'g')
  endfor
endfunction

command -range -nargs=+ ReplaceMe call ReplaceMe(<line1>, <line2>, <f-args>)
