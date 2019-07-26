if exists('g:loaded_nextlast')
  finish
endif
let g:loaded_nextlast = 1

" Operator motion for In Next ( in line
onoremap <silent> in( :<C-u>normal! f(vi(<CR>
" Operator motion for In Last ( in line
onoremap <silent> il( :<C-u>normal! F)vi(<CR>
" Operator motion for Around Next ( in line
onoremap <silent> an( :<C-u>normal! f(va(<CR>
" Operator motion for Around Last ( in line
onoremap <silent> al( :<C-u>normal! F)va(<CR>
" Operator motion for In Next { in line
onoremap <silent> in{ :<C-u>normal! f{vi{<CR>
" Operator motion for In Last { in line
onoremap <silent> il{ :<C-u>normal! F}vi{<CR>
" Operator motion for Around Next { in line
onoremap <silent> an{ :<C-u>normal! f{va{<CR>
" Operator motion for Around Last { in line
onoremap <silent> al{ :<C-u>normal! F}va{<CR>
