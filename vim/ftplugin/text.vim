" Vim filetype plugin
" Language:              Text
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

" Wrap at 78 characters
setlocal textwidth=78
" Spell check on, by default
setlocal spell spelllang=en_us
" Automagically reformat things as you type. This helps in the case where you
" insert into a paragraph and don't want to rewrap it on your own
set formatoptions+=a

let b:undo_ftplugin .= 'setlocal textwidth< spell< spelllang< formatoptions<'
