" Maintainer:       D. Ben Knoble <ben.knoble@gmail.com>

" Global function for calling terminal with the appropriate interpreter
" b:interpreter controls the program run
function! benknoble#terminal(...) abort
  let l:interpreter = get(b:, 'interpreter', &shell)
  let l:command = 'term'
  if a:0
    for l:opt in a:000
      let l:command .= printf(' %s', opt)
    endfor
  endif
  let l:command .= printf(' %s', l:interpreter)
  execute l:command
endfunction

" Makes [I nicer to navigate
function! benknoble#findword() abort
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

" Get the directory of a file on the command line
function! benknoble#current_file_directory(keymap) abort
  let l:command_type = getcmdtype()
  if l:command_type isnot# ':'
    return a:keymap
  endif
  let l:dir = expand('%:h')
  if empty(l:dir)
    let l:dir = '.'
  endif
  return l:dir . '/'
endfunction
