" Vim filetype plugin
" Language:              Interactive git-rebase
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

" Commands defined in $VIMRUNTIME/ftplugin/gitrebase.vim
nnoremap <buffer> <silent> <LocalLeader>p :Pick<CR>
nnoremap <buffer> <silent> <LocalLeader>s :Squash<CR>
nnoremap <buffer> <silent> <LocalLeader>e :Edit<CR>
nnoremap <buffer> <silent> <LocalLeader>r :Reword<CR>
nnoremap <buffer> <silent> <LocalLeader>f :Fixup<CR>
nnoremap <buffer> <silent> <LocalLeader>c :Cycle<CR>

if !exists("*MyGitRebaseFtpluginUndo")
  function MyGitRebaseFtpluginUndo()
    silent! nunmap <buffer> <LocalLeader>p
    silent! nunmap <buffer> <LocalLeader>s
    silent! nunmap <buffer> <LocalLeader>e
    silent! nunmap <buffer> <LocalLeader>r
    silent! nunmap <buffer> <LocalLeader>f
    silent! nunmap <buffer> <LocalLeader>c
  endfunction
endif

let b:undo_ftplugin .= 'call MyGitRebaseFtpluginUndo()'
