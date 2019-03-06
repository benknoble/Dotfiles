" Vim filetype plugin for folding
" Language:              Ruby
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

let ruby_fold = 1

let b:undo_ftplugin = ftplugin#undo({
      \ 'vars': [
      \   'ruby_fold',
      \ ],
      \ })
