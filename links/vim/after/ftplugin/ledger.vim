" Vim filetype plugin
" Language:              (h)ledger journals
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" widen maximum width for long account names, date tags, etc. (also that so that
" gq doesn't screw up tags when formatting)
setlocal textwidth=150

let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ opts: [
      \   'textwidth',
      \ ],
      \ })
