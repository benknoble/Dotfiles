" Vim filetype plugin
" Language:              Interactive git-rebase
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" Commands defined in $VIMRUNTIME/ftplugin/gitrebase.vim
nnoremap <buffer> <silent> <LocalLeader>p :Pick<CR>
nnoremap <buffer> <silent> <LocalLeader>s :Squash<CR>
nnoremap <buffer> <silent> <LocalLeader>e :Edit<CR>
nnoremap <buffer> <silent> <LocalLeader>r :Reword<CR>
nnoremap <buffer> <silent> <LocalLeader>f :Fixup<CR>
nnoremap <buffer> <silent> <LocalLeader>c :Cycle<CR>

let b:undo_ftplugin = ftplugin#undo({
      \ 'maps': [
      \   [ 'n', '<LocalLeader>p' ],
      \   [ 'n', '<LocalLeader>s' ],
      \   [ 'n', '<LocalLeader>e' ],
      \   [ 'n', '<LocalLeader>r' ],
      \   [ 'n', '<LocalLeader>f' ],
      \   [ 'n', '<LocalLeader>c' ],
      \ ],
      \ })
