" Vim filetype plugin
" Language:              lisp
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

let b:interpreter = 'clisp'

nnoremap <buffer> <Localleader>l :call lisp#load(expand('%'))<CR>
nnoremap <buffer> <Localleader>L :call lisp#load(input('(load) ', expand('%'), 'file'))<CR>

nmap <buffer> <Localleader>qe ysiebaquote <Esc>
nmap <buffer> <Localleader>qf ysafbaquote <Esc>

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
      \   [ 'n', '<Localleader>qe' ],
      \   [ 'n', '<Localleader>qe' ],
      \ ],
      \ 'funcs': [
      \ ],
      \ })
