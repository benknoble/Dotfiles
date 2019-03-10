" Vim filetype plugin
" Language:              Scala
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

let b:interpreter = 'sbt'

let b:undo_ftplugin = ftplugin#undo({
      \ 'vars': [
      \   'b:interpreter',
      \ ],
      \ })
