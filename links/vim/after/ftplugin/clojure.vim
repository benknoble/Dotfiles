" Vim filetype plugin
" Language:              clojure
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

let b:interpreter = 'clj'

" don't know the equivalent yet
" nnoremap <buffer> <Localleader>l :call lisp#load(expand('%'))<CR>
" nnoremap <buffer> <Localleader>L :call lisp#load(input('(load) ', expand('%'), 'file'))<CR>

nmap <buffer> <Localleader>qe ysiebaquote <Esc>:silent! call repeat#set("\<Localleader>qe", -1)<CR>
nmap <buffer> <Localleader>qf ysafbaquote <Esc>:silent! call repeat#set("\<Localleader>qf", -1)<CR>

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
      \   [ 'n', '<Localleader>qf' ],
      \ ],
      \ 'funcs': [
      \ ],
      \ })
