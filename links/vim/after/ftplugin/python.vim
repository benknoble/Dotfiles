" Vim filetype plugin
" Language:              Python
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

let python_highlight_all = 1
let b:interpreter = 'python'

setlocal textwidth=79

nnoremap <buffer> <LocalLeader>t :term python setup.py test -q<CR>

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'textwidth',
      \ ],
      \ 'maps': [
      \   [ 'n', '<LocalLeader>t' ],
      \ ],
      \ 'vars': [
      \   'python_highlight_all',
      \   'b:interpreter',
      \ ],
      \ })
