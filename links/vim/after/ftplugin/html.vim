" Vim filetype plugin
" Language:              HTML
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" Tab settings
setlocal shiftwidth=2 softtabstop=2

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'shiftwidth',
      \   'softtabstop',
      \ ],
      \ })
