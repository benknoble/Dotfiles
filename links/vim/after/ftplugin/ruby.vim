" Vim filetype plugin
" Language:              Ruby
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

" Default to using ruby interactively as the compiler
" Require manual setup of compiler for other projects
compiler ruby

nnoremap <buffer> <LocalLeader>r :make %<CR>

if !exists("*MyRubyFtpluginUndo")
  function MyRubyFtpluginUndo()
    setlocal textwidth<
    setlocal shiftwidth<
    setlocal softtabstop<
    setlocal errorformat<
    setlocal makeprg<

    silent! nunmap <buffer> <LocalLeader>r
  endfunction
endif

let b:undo_ftplugin .= 'call MyRubyFtpluginUndo()'
