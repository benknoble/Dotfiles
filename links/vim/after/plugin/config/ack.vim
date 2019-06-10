if ! exists(':Ack')
  finish
endif

nnoremap <Leader>a :Ack!<space>
nnoremap <silent> <Leader>A :Ack! <cword><CR>
nnoremap <silent> <Leader><C-a> :Ack! --nosmart-case <cword><CR>
