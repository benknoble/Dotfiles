" Vim filetype plugin
" Language:              [ba]sh script
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

" Wrap at 80 characters
setlocal textwidth=80
" Indent two spaces
setlocal shiftwidth=2 softtabstop=2

xnoremap <buffer> <silent> iv :<C-u>call sh#in_parameter_expansion()<CR>
onoremap <buffer> <silent> iv :<C-u>call sh#in_parameter_expansion()<CR>

" technically we're overriding the "in-sentence" motion here, but I can live
" with that
xnoremap <buffer> <silent> is :<C-u>call sh#in_subshell()<CR>
onoremap <buffer> <silent> is :<C-u>call sh#in_subshell()<CR>

" Relies on surround.vim and custom text object above
nmap <buffer> <silent> <LocalLeader>qv ysiv"
nmap <buffer> <silent> <LocalLeader>qs ysis"

if !exists("*MyShFtpluginUndo")
  function MyShFtpluginUndo()
    setlocal textwidth<
    setlocal shiftwidth<
    setlocal softtabstop<
    setlocal iskeyword<
    silent! xunmap <buffer> iv
    silent! ounmap <buffer> iv
    silent! ounmap <buffer> <LocalLeader>qv
    silent! xunmap <buffer> is
    silent! ounmap <buffer> is
    silent! ounmap <buffer> <LocalLeader>qs
  endfunction
endif

let b:undo_ftplugin .= 'call MyShFtpluginUndo()'
