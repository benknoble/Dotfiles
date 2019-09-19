" Vim filetype plugin
" Language:              sml
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

let b:interpreter = 'sml'

let b:undo_ftplugin = ftplugin#undo({
      \ 'vars': [
      \   'b:interpreter',
      \ ],
      \ })
