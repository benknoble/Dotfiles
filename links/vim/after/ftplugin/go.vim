" Vim filetype plugin
" Language:              Go
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

nnoremap <buffer> <localleader>t :compiler gotest <bar> make <bar> compiler go<CR>
nnoremap <buffer> <localleader>c :GoCoverage toggle<CR>

" Indent settings
setlocal tabstop=4
setlocal shiftwidth=0
setlocal softtabstop=0

let g:go_auto_type_info = 1

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'tabstop',
      \   'shiftwidth',
      \   'softtabstop',
      \ ],
      \ 'maps': [
      \   [ 'n', '<LocalLeader>t' ],
      \   [ 'n', '<LocalLeader>c' ],
      \ ],
      \ })
