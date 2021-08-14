if !exists(':Fileselect')
  finish
endif

let s:popsikey_fuzzy_id = popsikey#register('__z', [
      \ #{ key: 'e', info: 'find/edit/split file', action: ":Fileselect\<CR>" },
      \ #{ key: 'v', info: 'vsplit file', action: ":vertical Fileselect\<CR>" },
      \ #{ key: 't', info: 'tabedit file', action: ":tab Fileselect\<CR>" },
      \ ],
      \ #{
      \ title: ' Fuzzy find files ',
      \ })
silent! nunmap __z

call popsikey#extend(g:popsikey_edit_id, [
      \ #{
      \   key: 'z',
      \   info: 'fuzzy find',
      \   action: s:popsikey_fuzzy_id,
      \ },
      \ ],
      \ #{})
