" Vim filetype plugin
" Language:              coq
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

Conceal

let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ custom: [
      \   'Reveal',
      \ ],
      \ })
