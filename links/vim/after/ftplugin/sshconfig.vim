" Vim filetype plugin
" Language:              ssh_config
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

nnoremap <silent> <buffer> K :call ssh#man(expand('<cword>'))<CR>

if !exists("*MySSH_configFtpluginUndo")
  function MySSH_configFtpluginUndo()
    silent! nunmap <buffer> K
  endfunction
endif

let b:undo_ftplugin .= 'call MySSH_configFtpluginUndo()'
