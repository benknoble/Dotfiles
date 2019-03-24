" Vim filetype plugin
" Language:              Java
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" Indent two spaces
setlocal shiftwidth=2 softtabstop=2

setlocal foldmethod=syntax

let b:interpreter = 'bash -c "make jdb || jdb"'

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'shiftwidth',
      \   'softtabstop',
      \   'foldmethod',
      \ ],
      \ 'vars': [
      \   'b:interpreter',
      \ ],
      \ })
