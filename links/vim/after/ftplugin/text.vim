" Vim filetype plugin
" Language:              Text
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" Wrap at 78 characters
setlocal textwidth=78
" Spell check on, by default
setlocal spell spelllang=en_us

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'textwidth',
      \   'spell',
      \   'spelllang',
      \ ],
      \ })
