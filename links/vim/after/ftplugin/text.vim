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

if !exists("*MyTextFtpluginUndo")
  function MyTextFtpluginUndo()
    setlocal spell<
    setlocal spelllang<
    setlocal textwidth<
  endfunction
endif

let b:undo_ftplugin .= 'call MyTextFtpluginUndo()'
