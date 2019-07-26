if exists('g:loaded_CR')
  finish
endif
let g:loaded_CR = 1

" Insert blank lines with <CR>
nnoremap <CR> o<esc>

augroup CRfix
  au!
  " Quickfix, Location list, &c. remap <CR> to work as expected
  autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
  autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>
augroup END
