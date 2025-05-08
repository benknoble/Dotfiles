" Vim filetype plugin
" Language:              Git config file
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" Use hard (i.e. actual) tabs
setlocal noexpandtab
" And of the right length
setlocal tabstop=8 shiftwidth=8 softtabstop=8

nnoremap <buffer> K :call bk#gitconfig#man(getline('.'))<CR>

" disable EditorConfig here
let b:EditorConfig_disable = 1

let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ opts: [
      \   'tabstop',
      \   'shiftwidth',
      \   'softtabstop',
      \   'expandtab',
      \ ],
      \ maps: [
      \   [ 'n', 'K' ],
      \ ],
      \ vars: [
      \   'b:EditorConfig_disable',
      \ ],
      \ })
