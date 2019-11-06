" Vim filetype plugin
" Language:              Vim script
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" Indent two spaces
setlocal shiftwidth=2 softtabstop=2

" Use :help for K in vimscript
setlocal keywordprg=:help

" Execute the current line
nnoremap <buffer> <LocalLeader>el :execute getline('.')<CR>
" Execute file
nnoremap <buffer> <LocalLeader>ef :source %<CR>

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'shiftwidth',
      \   'softtabstop',
      \   'keywordprg',
      \ ],
      \ 'maps': [
      \   [ 'n', '<LocalLeader>el' ],
      \   [ 'n', '<LocalLeader>ef' ],
      \ ],
      \ })
