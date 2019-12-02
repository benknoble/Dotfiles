" Vim filetype plugin
" Language:              sml
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

let b:interpreter = 'sml'

setlocal commentstring=(*\ %s\ *)
nnoremap <buffer> <Localleader>l :call sml#load(expand('%'))<CR>
nnoremap <buffer> <Localleader>L :call sml#load(input('use ', expand('%'), 'file'))<CR>

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'commentstring',
      \ ],
      \ 'vars': [
      \   'b:interpreter',
      \ ],
      \ 'maps': [
      \   [ 'n', '<Localleader>l' ],
      \   [ 'n', '<Localleader>L' ],
      \ ],
      \ })
