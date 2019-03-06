" Vim filetype plugin
" Language:              C
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" Find headers *when we want them*!
setlocal path+=/usr/local/include,/usr/include

" Rebuild tags
nnoremap <buffer> <LocalLeader>tr :!ctags --extra=+f -R *<CR><CR>

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'path',
      \ ],
      \ 'maps': [
      \   [ 'n', '<LocalLeader>tr' ],
      \ ],
      \ })
