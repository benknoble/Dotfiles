" Vim filetype plugin
" Language:              #lang frosthaven-manager/bestiary
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

let b:interpreter = 'racket'
let b:ale_linter_aliases = 'racket'
setlocal syntax=racket

setlocal shiftwidth=2 softtabstop=2
let &l:include = '\v(import-monsters "\zs[^"]*\ze"|aoe\(\zs[^)]*\ze\))'
let &l:define = '\vbegin-(monster|ability-deck)'

" Retabularize stats; recursive for the `ii` text-object
nmap <buffer> <localleader>i mz!iicolumn -t<enter>:*s/^/  /<bar>*s/\>\s\+\</ /g<enter>`z

let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ opts: [
      \   'shiftwidth',
      \   'softtabstop',
      \   'syntax',
      \   'include',
      \   'define',
      \ ],
      \ vars: [
      \   'b:interpreter',
      \   'b:ale_linter_aliases',
      \ ],
      \ maps: [
      \   ['n', '<localleader>i'],
      \ ],
      \ })
