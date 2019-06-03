" Vim filetype plugin
" Language:              Git config file
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" Use hard (i.e. actual) tabs
setlocal noexpandtab
" And of the right length
setlocal tabstop=8 shiftwidth=8 softtabstop=8

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'tabstop',
      \   'shiftwidth',
      \   'softtabstop',
      \   'expandtab',
      \ ],
      \ })
