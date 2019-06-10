if exists('g:loaded_fold')
  finish
endif
let g:loaded_fold = 1

command -bar -bang -nargs=* Fold call fold#Fold(<q-args>, '<bang>')
