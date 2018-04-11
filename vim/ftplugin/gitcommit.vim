" Vim filetype plugin
" Language:              Git commit file
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

" Spell check on for commit messages
setlocal spell spelllang=en_us

let b:undo_ftplugin .= 'setlocal spell< spelllang<'
