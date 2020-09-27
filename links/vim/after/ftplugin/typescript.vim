" Vim filetype plugin
" Language:              typescript
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

setlocal shiftwidth=2 softtabstop=2

let b:undo_ftplugin = bk#ftplugin#undo({
      \ 'opts': [
      \   'shiftwidth',
      \   'softtabstop',
      \ ],
      \ })
