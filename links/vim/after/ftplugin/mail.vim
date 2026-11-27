" Vim filetype plugin
" Language:              Mail
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

setlocal formatlistpat+=\\\|^\\s*•\\s\\+

let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ opts: [
      \   'formatlistpat',
      \ ],
      \ })
