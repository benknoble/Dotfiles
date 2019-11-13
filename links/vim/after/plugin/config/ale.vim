if ! exists(':ALEInfo')
  finish
endif

let g:ale_set_signs = 0

let g:ale_lint_on_enter = 0

let g:ale_linters = {
      \ 'python': 'all',
      \ 'scala': [],
      \ 'java': [],
      \ }

if has('osx') || has('mac')
  let g:ale_linters_ignore = {
        \ 'c': [ 'gcc' ],
        \ }
endif
