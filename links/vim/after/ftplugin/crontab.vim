" Vim filetype plugin
" Language:              Crontab
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

setlocal commentstring=#\ %s

let b:undo_ftplugin = bk#ftplugin#undo({
      \ 'opts': [
      \   'commentstring',
      \ ],
      \ })
