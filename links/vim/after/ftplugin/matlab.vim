" Vim filetype plugin
" Language:              matlab
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

let b:interpreter = 'matlab_cli'

setlocal textwidth=80
setlocal shiftwidth=4 softtabstop=4

let b:undo_ftplugin = bk#ftplugin#undo({
      \ 'opts': [
      \   'textwidth',
      \   'shiftwidth',
      \   'softtabstop',
      \ ],
      \ 'vars': [
      \   'b:interpreter',
      \ ],
      \ })
