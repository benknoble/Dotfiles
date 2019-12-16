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

" lengthen prolog timeout
let g:ale_prolog_swipl_timeout = 10
" no sandboxing
let g:ale_prolog_swipl_load = 'current_prolog_flag(argv, [File]), load_files(File, [sandboxed(false)]), halt.'
