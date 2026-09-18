augroup Suspense
  autocmd!
  autocmd BufNewFile,BufWinEnter ~/.wiki/suspense call bk#suspense#make()
augroup end
