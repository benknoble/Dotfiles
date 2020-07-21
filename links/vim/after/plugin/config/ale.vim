if ! exists(':ALEInfo')
  finish
endif

set completefunc=ale#completion#OmniFunc

let g:ale_set_signs = 0
let g:ale_lint_on_enter = 0
let g:ale_fix_on_save = 1

let g:ale_linters = {
      \ 'python': 'all',
      \ 'scala': [],
      \ 'java': [],
      \ 'zsh': ['shell'],
      \ }

if executable('rust-analyzer')
  let g:ale_linters.rust = ['analyzer']
endif

let g:ale_fixers = {
      \ 'python': ['black'],
      \ 'rust': ['rustfmt'],
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

" keep python files limited in line length (88 is too much)
" see ~/.vim/after/ftplugin/python.vim
let g:ale_python_black_options = '--line-length 79'
