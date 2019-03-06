" Vim filetype plugin
" Language:              puppet files
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

setlocal commentstring=#%s

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'commentstring',
      \ ],
      \ })
