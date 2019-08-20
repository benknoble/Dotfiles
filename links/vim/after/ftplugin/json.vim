" Vim filetype plugin
" Language:              json
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

setlocal formatexpr=json#format()
setlocal textwidth=0

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'formatexpr',
      \   'textwidth',
      \ ],
      \ 'vars': [
      \ ],
      \ 'commands': [
      \ ],
      \ 'maps': [
      \ ],
      \ 'funcs': [
      \ ],
      \ })
