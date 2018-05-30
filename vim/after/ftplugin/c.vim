" Vim filetype plugin
" Language:              C
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

" Add system tags
setlocal tags+=~/.sys_c_tags

" Find headers *when we want them*!
setlocal path+=/usr/local/include,/usr/include

" Rebuild tags
nnoremap <buffer> <LocalLeader>tr :!ctags --extra=+f -R *<CR><CR>

let b:undo_ftplugin .= 'setlocal tags< path<'
let b:undo_ftplugin .= ' | nunmap <buffer> <LocalLeader>tr'
