" Vim filetype plugin
" Language:              sml
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

let b:interpreter = 'sml'

setlocal commentstring=(*\ %s\ *)
setlocal shiftwidth=2 softtabstop=2
setlocal iskeyword+=',$,#

let b:match_words = '\<let\>:\<in\>:\<end\>'

nnoremap <buffer> <Localleader>l :call sml#load(expand('%'))<CR>
nnoremap <buffer> <Localleader>L :call sml#load(input('use ', expand('%'), 'file'))<CR>

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'shiftwidth',
      \   'softtabstop',
      \   'commentstring',
      \   'iskeyword',
      \ ],
      \ 'vars': [
      \   'b:interpreter',
      \ ],
      \ 'maps': [
      \   [ 'n', '<Localleader>l' ],
      \   [ 'n', '<Localleader>L' ],
      \ ],
      \ })
