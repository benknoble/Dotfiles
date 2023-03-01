" Vim filetype plugin
" Language:              #lang frosthaven-manager/bestiary
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

let b:interpreter = 'racket'
let b:ale_linter_aliases = 'racket'
setlocal syntax=racket

setlocal shiftwidth=2 softtabstop=2

let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ opts: [
      \   'shiftwidth',
      \   'softtabstop',
      \   'syntax',
      \ ],
      \ vars: [
      \   'b:interpreter',
      \   'b:ale_linter_aliases',
      \ ],
      \ })
