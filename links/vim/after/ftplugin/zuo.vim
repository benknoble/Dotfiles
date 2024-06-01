" Vim filetype plugin
" Language:              zuo
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

let b:interpreter = 'racket'

setlocal shiftwidth=2 softtabstop=2

nmap <buffer> <Localleader>qe ysiebaquote <Esc>:silent! call repeat#set("\<Localleader>qe", -1)<CR>
nmap <buffer> <Localleader>qf ysafbaquote <Esc>:silent! call repeat#set("\<Localleader>qf", -1)<CR>

let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ opts: [
      \   'shiftwidth',
      \   'softtabstop',
      \ ],
      \ vars: [
      \   'b:interpreter',
      \ ],
      \ maps: [
      \   [ 'n', '<Localleader>qe' ],
      \   [ 'n', '<Localleader>qf' ],
      \ ],
      \ })
