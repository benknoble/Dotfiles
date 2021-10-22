" Vim filetype plugin
" Language:              json
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

setlocal formatexpr=bk#json#format()
setlocal textwidth=0

let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ opts: [
      \   'formatexpr',
      \   'textwidth',
      \ ],
      \ vars: [
      \ ],
      \ commands: [
      \ ],
      \ maps: [
      \ ],
      \ funcs: [
      \ ],
      \ })
