" Functions for dealing with the terminal

" Global function for calling terminal with the appropriate interpreter
" b:interpreter controls the program run
function! terminal#run(...) abort
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
