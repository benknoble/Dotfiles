" Vim filetype plugin
" Language:              lisp
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

let b:interpreter = 'clisp'

nnoremap <Localleader>l :call lisp#load(expand('%'))<CR>
nnoremap <Localleader>L :call lisp#load(input('file.lisp> ', expand('%'), 'file'))<CR>

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \ ],
      \ 'vars': [
      \   'b:interpreter',
      \ ],
      \ 'commands': [
      \ ],
      \ 'maps': [
      \   [ 'n', '<Localleader>l' ],
      \   [ 'n', '<Localleader>L' ],
      \ ],
      \ 'funcs': [
      \ ],
      \ })
