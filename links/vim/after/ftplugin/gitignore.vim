" Vim filetype plugin
" Language:              gitignore
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

nnoremap <buffer> <LocalLeader>! :exec bk#gitignore#negate()<CR>
nnoremap <buffer> <LocalLeader>1 :exec bk#gitignore#negate()<CR>

let b:undo_ftplugin = bk#ftplugin#undo({
      \ 'maps': [
      \   [ 'n', '<LocalLeader>!' ],
      \   [ 'n', '<LocalLeader>1' ],
      \ ],
      \ })
