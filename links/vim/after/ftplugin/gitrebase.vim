" Vim filetype plugin
" Language:              Interactive git-rebase
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" Commands defined in $VIMRUNTIME/ftplugin/gitrebase.vim
nnoremap <buffer> <LocalLeader>p :Pick<CR>
nnoremap <buffer> <LocalLeader>s :Squash<CR>
nnoremap <buffer> <LocalLeader>e :Edit<CR>
nnoremap <buffer> <LocalLeader>r :Reword<CR>
nnoremap <buffer> <LocalLeader>f :Fixup<CR>
nnoremap <buffer> <LocalLeader>d :Drop<CR>
nnoremap <buffer> <LocalLeader>c :Cycle<CR>

let &l:keywordprg=':Git show '

let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ opts: [
      \   'keywordprg',
      \ ],
      \ maps: [
      \   [ 'n', '<LocalLeader>p' ],
      \   [ 'n', '<LocalLeader>s' ],
      \   [ 'n', '<LocalLeader>e' ],
      \   [ 'n', '<LocalLeader>r' ],
      \   [ 'n', '<LocalLeader>f' ],
      \   [ 'n', '<LocalLeader>c' ],
      \ ],
      \ })
