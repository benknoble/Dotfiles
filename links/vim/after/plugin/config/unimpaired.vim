if ! exists('g:loaded_unimpaired')
  finish
endif

call popsikey#register('<Leader>[', [
      \ #{ key: 'c', info: 'colder', action: ":colder\<CR>", },
      \ #{ key: 'l', info: 'lolder', action: ":lolder\<CR>", },
      \ ],
      \ #{
      \ title: ' Extended unimpaired ',
      \ })

call popsikey#register('<Leader>]', [
      \ #{ key: 'c', info: 'cnewer', action: ":cnewer\<CR>", },
      \ #{ key: 'l', info: 'lnewer', action: ":lnewer\<CR>", },
      \ ],
      \ #{
      \ title: ' Extended unimpaired ',
      \ })
