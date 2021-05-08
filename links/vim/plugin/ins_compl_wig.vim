if exists('g:loaded_ins_compl_wig')
  finish
endif
let g:loaded_ins_compl_wig = 1

augroup WIG
  autocmd!
  autocmd InsertEnter *
        \ if !exists('b:old_wildignore') |
        \   let b:old_wildignore = &wildignore |
        \   set wildignore& |
        \ endif
  autocmd InsertLeave *
        \ if exists('b:old_wildignore') |
        \   let &wildignore = b:old_wildignore |
        \   unlet b:old_wildignore |
        \ endif
augroup end
