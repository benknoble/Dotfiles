" Vim filetype plugin
" Language:              gitignore
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

nnoremap <buffer> <silent> <LocalLeader>! :exec gitignore#negate()<CR>
nnoremap <buffer> <silent> <LocalLeader>1 :exec gitignore#negate()<CR>

let b:undo_ftplugin = ftplugin#undo({
      \ 'maps': [
      \   [ 'n', '<LocalLeader>!' ],
      \   [ 'n', '<LocalLeader>1' ],
      \ ],
      \ })
