" Vim filetype plugin
" Language:              sml
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

let b:interpreter = 'rlwrap sml'

setlocal shiftwidth=2 softtabstop=2
setlocal iskeyword+=',$,#

let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ opts: [
      \   'shiftwidth',
      \   'softtabstop',
      \   'iskeyword',
      \ ],
      \ vars: [
      \   'b:interpreter',
      \ ],
      \ })
