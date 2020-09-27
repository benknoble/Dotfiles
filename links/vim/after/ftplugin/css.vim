" Vim filetype plugin
" Language:              CSS
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" Tab settings
setlocal shiftwidth=2 softtabstop=2

let b:undo_ftplugin = bk#ftplugin#undo({
      \ 'opts': [
      \   'shiftwidth',
      \   'softtabstop',
      \ ],
      \ })
