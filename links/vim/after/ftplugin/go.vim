" Vim filetype plugin
" Language:              Go
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" Build Go files
nnoremap <buffer> <localleader>b :<C-u>call go#build_go_files()<CR>
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

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'keywordprg',
      \   'shiftwidth',
      \   'softtabstop',
      \ ],
      \ 'maps': [
      \   [ 'n', '<LocalLeader>b' ],
      \   [ 'n', '<LocalLeader>r' ],
      \   [ 'n', '<LocalLeader>t' ],
      \   [ 'n', '<LocalLeader>c' ],
      \ ],
      \ 'vars': [
      \   'g:go_highlight_types',
      \   'g:go_highlight_fields',
      \   'g:go_highlight_functions',
      \   'g:go_highlight_methods',
      \   'g:go_highlight_extra_types',
      \   'g:go_auto_type_info',
      \ ],
      \ })
