if exists('g:loaded_fold')
  finish
endif
let g:loaded_fold = 1

command -bar -bang -nargs=* Fold call fold#Fold(<q-args>, '<bang>')

set foldmethod=marker

" Start with no folds
" Toggle with `zi`
set nofoldenable

" Enable folds in markdown from ftplugin
let g:markdown_folding = 1
