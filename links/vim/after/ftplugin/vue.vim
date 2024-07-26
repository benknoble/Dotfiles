" Vim filetype plugin
" Language:              Vue
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" Indent two spaces
setlocal shiftwidth=2 softtabstop=2

let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ opts: [
      \   'shiftwidth',
      \   'softtabstop',
      \ ],
      \ })
