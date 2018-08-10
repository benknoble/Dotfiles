" Vim filetype plugin
" Language:              Python
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

let python_highlight_all = 1

setlocal textwidth=79

nnoremap <buffer> <LocalLeader>P :term python<CR>
nnoremap <buffer> <LocalLeader>p :term ++close python<CR>

let b:undo_ftplugin .= "setlocal textwidth<"
let b:undo_ftplugin .= " | unlet! python_highlight_all"
let b:undo_ftplugin .= " | exe 'nunmap <buffer> <LocalLeader>P'"
let b:undo_ftplugin .= " | exe 'nunmap <buffer> <LocalLeader>p'"
