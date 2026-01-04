vim9script

if exists('g:loaded_hyperlink')
  finish
endif
g:loaded_hyperlink = 1

import autoload 'bk/hyperlink.vim'

command -bar -nargs=? Hyperlink hyperlink.Hyperlink(empty(<q-args>) ? @+ : <q-args>)
command -bar RenumberLinks hyperlink.RenumberLinks()
