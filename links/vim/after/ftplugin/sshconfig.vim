" Vim filetype plugin
" Language:              ssh_config
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

nnoremap <buffer> K :call bk#ssh#man(expand('<cword>'))<CR>

let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ maps: [
      \   [ 'n', 'K' ],
      \ ],
      \ })
