" Vim filetype plugin
" Language:              toml
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

nnoremap [[ :call search('^\s*[', 'Wb')<CR>
nnoremap ]] :call search('^\s*[', 'W')<CR>

let b:undo_ftplugin = bk#ftplugin#undo({
      \ 'maps': [
      \   [ 'n', '[[' ],
      \   [ 'n', ']]' ],
      \ ],
      \ })
