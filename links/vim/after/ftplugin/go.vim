" Vim filetype plugin
" Language:              Go
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

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

if !exists("*MyGoFtpluginUndo")
  function MyGoFtpluginUndo()
    setlocal shiftwidth<
    setlocal softtabstop<
    setlocal keywordprg<

    silent! nunmap <buffer> <localleader>b
    silent! nunmap <buffer> <localleader>r
    silent! nunmap <buffer> <localleader>t
    silent! nunmap <buffer> <localleader>c

    unlet! g:go_highlight_types
    unlet! g:go_highlight_fields
    unlet! g:go_highlight_functions
    unlet! g:go_highlight_methods
    unlet! g:go_highlight_extra_types
    unlet! g:go_auto_type_info

  endfunction
endif

let b:undo_ftplugin .= 'call MyGoFtpluginUndo()'
