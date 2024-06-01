" Vim filetype plugin
" Language:              info
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

call sexp#filetype#do_filetype('scheme')

let b:interpreter = 'racket'

nmap <buffer> <Localleader>qe ysiebaquote <Esc>:silent! call repeat#set("\<Localleader>qe", -1)<CR>
nmap <buffer> <Localleader>qf ysafbaquote <Esc>:silent! call repeat#set("\<Localleader>qf", -1)<CR>

let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ vars: [
      \   'b:interpreter',
      \ ],
      \ maps: [
      \   [ 'n', '<Localleader>qe' ],
      \   [ 'n', '<Localleader>qf' ],
      \ ],
      \ })
