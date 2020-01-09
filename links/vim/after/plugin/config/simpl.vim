if ! (&rtp =~# 'simpl')
  finish
endif

nnoremap <leader>t :call simpl#repl('++close')<CR>
nnoremap <leader>T :call simpl#repl()<CR>
nnoremap <localleader>l :call simpl#load()<CR>
nnoremap <localleader>L :call simpl#prompt_and_load()<CR>
