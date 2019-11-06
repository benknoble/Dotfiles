" Vim filetype plugin
" Language:              ssh_config
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

nnoremap <buffer> K :call ssh#man(expand('<cword>'))<CR>

let b:undo_ftplugin = ftplugin#undo({
      \ 'maps': [
      \   [ 'n', 'K' ],
      \ ],
      \ })
