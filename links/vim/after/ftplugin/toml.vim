" Vim filetype plugin
" Language:              toml
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

nnoremap [[ :call search('^\s*[', 'Wb')<CR>
nnoremap ]] :call search('^\s*[', 'W')<CR>

setlocal softtabstop=2 shiftwidth=2

let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ opts: [
      \   'softtabstop',
      \   'shiftwidth',
      \ ],
      \ maps: [
      \   [ 'n', '[[' ],
      \   [ 'n', ']]' ],
      \ ],
      \ })
