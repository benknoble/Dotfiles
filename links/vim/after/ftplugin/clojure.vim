" Vim filetype plugin
" Language:              clojure
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

let b:interpreter = 'clj -Arebel'

nmap <buffer> <Localleader>qe ysiebaquote <Esc>:silent! call repeat#set("\<Localleader>qe", -1)<CR>
nmap <buffer> <Localleader>qf ysafbaquote <Esc>:silent! call repeat#set("\<Localleader>qf", -1)<CR>

inoremap <buffer> <expr> $ lisp#at_start_of_form() ? 'partial' : '$'
inoremap <buffer> <expr> o lisp#at_start_of_form() ? 'comp' : 'o'

setlocal lispwords+=->
setlocal lispwords+=->>
setlocal foldmethod=syntax

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'lispwords',
      \   'foldmethod',
      \ ],
      \ 'vars': [
      \   'b:interpreter',
      \ ],
      \ 'maps': [
      \   [ 'n', '<Localleader>l' ],
      \   [ 'n', '<Localleader>L' ],
      \   [ 'n', '<Localleader>qe' ],
      \   [ 'n', '<Localleader>qf' ],
      \   [ 'i', '$' ],
      \   [ 'i', 'o' ],
      \ ],
      \ })
