" Vim filetype plugin
" Language:              Git commit file
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

" Spell check on for commit messages
setlocal spell spelllang=en_us

" Make sure we don't use autoformatting
setlocal formatoptions-=a

function! s:find_diff()
  " find the diff cut line, wrapping
  call search('^#.*>8.*', 'w')
  " move 3 lines down
  +3
endfunction
nnoremap <buffer> <LocalLeader>d :call <SID>find_diff()<CR>

if !exists("*MyGitcommitFtpluginUndo")
  function MyGitcommitFtpluginUndo()
    setlocal spell<
    setlocal spelllang<
    setlocal formatoptions<
    silent! nunmap <buffer> <LocalLeader>d
    delfunction s:find_diff
  endfunction
endif

let b:undo_ftplugin .= 'call MyGitcommitFtpluginUndo()'
