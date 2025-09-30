" Vim filetype plugin
" Language:              Python
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

let python_highlight_all = 1
let b:interpreter = 'python3'
call bk#python#search_pipfile()

nnoremap <buffer> <LocalLeader>t :execute 'term' b:interpreter 'setup.py test -q'<CR>

let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ maps: [
      \   [ 'n', '<LocalLeader>t' ],
      \ ],
      \ vars: [
      \   'python_highlight_all',
      \   'b:interpreter',
      \ ],
      \ })
