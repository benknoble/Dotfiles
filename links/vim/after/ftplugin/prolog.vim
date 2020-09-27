" Vim filetype plugin
" Language:              prolog
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

let b:interpreter = 'swipl'

let b:undo_ftplugin = bk#ftplugin#undo({
      \ 'vars': [
      \   'b:interpreter',
      \ ],
      \ })
