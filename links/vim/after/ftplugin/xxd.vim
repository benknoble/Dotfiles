" Vim filetype plugin
" Language:              xxd
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" cache it
let g:xxd = get(g:, 'xxd', executable('xxd'))

if !g:xxd
  finish
endif

call hex#setup()
