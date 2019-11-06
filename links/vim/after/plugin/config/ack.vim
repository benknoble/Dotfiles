if ! exists(':Ack')
  finish
endif

nnoremap <Leader>a :Ack!<space>
nnoremap <Leader>A :Ack! <cword><CR>
nnoremap <Leader><C-a> :Ack! --nosmart-case <cword><CR>
