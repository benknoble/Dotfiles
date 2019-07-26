if exists('g:loaded_reload')
  finish
endif
let g:loaded_reload = 1

" Reload vimrc
if !exists(":Reload")
  command -bar Reload source $MYVIMRC
endif

" Reload with F5
nnoremap <F5> :Reload<CR>
" Or <Leader>[rR]
nnoremap <Leader>r :Reload<CR>
