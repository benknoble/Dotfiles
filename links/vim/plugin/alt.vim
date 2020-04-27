if exists('g:loaded_alt')
  finish
endif
let g:loaded_alt = 1

command -nargs=1 -complete=file Alt edit <args> | read # | 0 delete
