" Vim filetype plugin
" Language:              xml
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

setlocal shiftwidth=2 softtabstop=2

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'shiftwidth',
      \   'softtabstop',
      \ ],
      \ })
