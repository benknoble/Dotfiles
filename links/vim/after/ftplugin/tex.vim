" Vim filetype plugin
" Language:              LaTeX
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

setlocal spell

nnoremap <buffer> <LocalLeader>4 :s/\$/\\(/ <Bar> s/\$/\\)/<CR>

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'spell',
      \ ],
      \ 'maps': [
      \   [ 'n', '<LocalLeader>4' ],
      \ ],
      \ })
