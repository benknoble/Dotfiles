" Global function for calling terminal with the appropriate interpreter
" Maintainer:       D. Ben Knoble <ben.knoble@gmail.com>
" b:interpreter controls the program run

function! benknoble#terminal(...)
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
