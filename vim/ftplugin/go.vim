" Vim filetype plugin
" Language              Go
" Maintainer            Ben Knoble <ben.knoble@gmail.com>

function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    :GoTestCompile
  elseif l:file =~# '^\f\+\.go$'
    :GoBuild
  endif
endfunction

" Build Go files
nmap <buffer> <localleader>b :<C-u>call <SID>build_go_files()<CR>
" Run them
nmap <buffer> <localleader>r <Plug>(go-run)
" And test them
nmap <buffer> <localleader>t <Plug>(go-test)
" And get coverage
nmap <buffer> <localleader>c <Plug>(go-coverage-toggle)

" Get Go help
setlocal keywordprg=:GoDoc

" Indent settings
setlocal shiftwidth=8
setlocal softtabstop=8

" vim-go configuration
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_extra_types = 1

let g:go_auto_type_info = 1
