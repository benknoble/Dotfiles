" Vim filetype plugin
" Language:              [ba]sh script
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

xnoremap <buffer> <silent> iv :<C-u>call sh#in_parameter_expansion()<CR>
onoremap <buffer> <silent> iv :<C-u>call sh#in_parameter_expansion()<CR>

" Relies on surround.vim and custom text object above
nmap <buffer> <silent> <LocalLeader>qv ysiv"

if !exists("*MyShPEFtpluginUndo")
  function MyShPEFtpluginUndo()
    silent! xunmap <buffer> iv
    silent! ounmap <buffer> iv
    silent! ounmap <buffer> <LocalLeader>qv
  endfunction
endif

let b:undo_ftplugin .= 'call MyShPEFtpluginUndo()'
