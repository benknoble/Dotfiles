if ! exists(':AutoOrigamiFoldColumn')
  finish
endif

if has('autocmd')
  augroup autofoldcolumn
    au!
    " Automatically add foldcolumn if folds present
    au CursorHold,BufWinEnter,WinEnter * AutoOrigamiFoldColumn
  augroup END
end
