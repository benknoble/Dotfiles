augroup Notepad
  autocmd!
  autocmd BufNewFile,BufWinEnter ~/.wiki/notepad call notepad#make()
augroup END
