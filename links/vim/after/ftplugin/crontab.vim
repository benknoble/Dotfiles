" Vim filetype plugin
" Language:              Crontab
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

setlocal commentstring=#\ %s

if !exists("*MyCrontabFtpluginUndo")
  function MyCrontabFtpluginUndo()
    setlocal commentstring<
  endfunction
endif

let b:undo_ftplugin .= 'call MyCrontabFtpluginUndo()'
