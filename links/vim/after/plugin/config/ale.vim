if ! exists(':ALEInfo')
  finish
endif

let g:ale_set_signs = 0

let g:ale_linters = {
      \ 'python': 'all',
      \ 'java': [],
      \ }
