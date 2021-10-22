" Vim filetype plugin
" Language:              sml
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

let b:interpreter = 'rlwrap sml'

setlocal commentstring=(*\ %s\ *)
setlocal shiftwidth=2 softtabstop=2
setlocal iskeyword+=',$,#

let b:match_words = '\<let\>:\<in\>:\<end\>'

let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ opts: [
      \   'shiftwidth',
      \   'softtabstop',
      \   'commentstring',
      \   'iskeyword',
      \ ],
      \ vars: [
      \   'b:interpreter',
      \ ],
      \ })
