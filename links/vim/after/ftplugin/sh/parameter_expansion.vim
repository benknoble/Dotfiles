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


if !exists("*MyShPEFtpluginUndo")
  function MyShPEFtpluginUndo()
    silent! xunmap <buffer> iv
    silent! ounmap <buffer> iv
  endfunction
endif

let b:undo_ftplugin .= 'call MyShPEFtpluginUndo()'
