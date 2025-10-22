if ! exists('g:loaded_fugitive')
  finish
endif

call popsikey#register('<Leader>g', [
      \ #{ key: 'g', info: 'status', action: ":G\<CR>", },
      \ #{ key: ' ', info: ':tab G', action: ':G ', },
      \ ],
      \ #{
      \   title: ' Git ',
      \ })
