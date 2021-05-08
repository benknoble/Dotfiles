augroup Notepad
  autocmd!
  autocmd BufNewFile,BufWinEnter ~/.wiki/notepad call bk#notepad#make()
augroup end
