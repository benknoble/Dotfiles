if exists('g:loaded_wheel')
  finish
endif
let g:loaded_wheel = 1

augroup wheel_as_zip
  autocmd!
  autocmd BufRead *.whl call zip#Browse(expand('<amatch>'))
augroup END
