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

let b:undo_ftplugin .= 'setlocal textwidth< shiftwidth< softtabstop<'
let b:undo_ftplugin .= ' | setlocal errorformat< makeprg<'
let b:undo_ftplugin .= " | exe 'nunmap <buffer> <LocalLeader>r'"
