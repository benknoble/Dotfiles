if ! (&rtp =~# 'simpl')
  finish
endif

call popsikey#register('<Leader>t', [
      \ #{
      \   key: 't',
      \   info: 'terminal ++close',
      \   action: ":call simpl#repl('++close')\<CR>",
      \ },
      \ #{
      \   key: 'T',
      \   info: 'terminal',
      \   action: ":call simpl#repl()\<CR>",
      \ },
      \ #{
      \   key: 'l',
      \   info: 'load file',
      \   action: ":call simpl#load()\<CR>",
      \ },
      \ #{
      \   key: 'L',
      \   info: 'load input file',
      \   action: ":call simpl#prompt_and_load()\<CR>",
      \ },
      \ ],
      \ #{
      \ title: 'terminal',
      \ })
