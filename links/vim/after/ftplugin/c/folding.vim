" Vim filetype plugin for folding
" Language:              C
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

setlocal foldmethod=syntax

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'foldmethod',
      \ ],
      \ })
