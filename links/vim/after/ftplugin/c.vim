" Vim filetype plugin
" Language:              C
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

" Find headers *when we want them*!
setlocal path+=/usr/local/include,/usr/include

" Rebuild tags
nnoremap <buffer> <LocalLeader>tr :!ctags --extra=+f -R *<CR><CR>

if !exists("*MyCFtpluginUndo")
  function MyCFtpluginUndo()
    setlocal path<
    silent! nunmap <buffer> <LocalLeader>tr
  endfunction
endif

let b:undo_ftplugin .= 'call MyCFtpluginUndo()'
