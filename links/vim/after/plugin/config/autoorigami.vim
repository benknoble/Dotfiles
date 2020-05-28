if ! exists(':AutoOrigamiFoldColumn')
  finish
endif

if has('autocmd')
  augroup autofoldcolumn
    autocmd!
    " Automatically add foldcolumn if folds present
    autocmd CursorHold,BufWinEnter,WinEnter * AutoOrigamiFoldColumn
  augroup END
endif
