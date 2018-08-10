" Vim filetype plugin
" Language:              Git config file
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

" Use hard (i.e. actual) tabs
setlocal noexpandtab
" And of the right length
setlocal tabstop=8 shiftwidth=8

if !exists("*MyGitconfFtpluginUndo")
  function MyGitconfFtpluginUndo()
    setlocal noexpandtab<
    setlocal shiftwidth<
    setlocal tabstop<
  endfunction
endif

let b:undo_ftplugin .= 'call MyGitconfFtpluginUndo()'
