" Vim filetype plugin
" Language:              Scala
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

setlocal shiftwidth=2 softtabstop=2

let b:interpreter = 'sbt'

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'shiftwidth',
      \   'softtabstop',
      \ ],
      \ 'vars': [
      \   'b:interpreter',
      \ ],
      \ })
