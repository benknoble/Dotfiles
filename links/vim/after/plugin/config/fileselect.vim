if !exists(':Fileselect')
  finish
endif

call popsikey#extend(g:popsikey_edit_id, [
      \ #{
      \   key: 'z',
      \   info: 'fuzzy find',
      \   action: ":Fileselect\<CR>",
      \ },
      \ ],
      \ #{})
