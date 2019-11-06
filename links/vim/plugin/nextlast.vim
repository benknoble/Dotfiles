if exists('g:loaded_nextlast')
  finish
endif
let g:loaded_nextlast = 1

" Operator motion for In Next ( in line
onoremap in( :<C-u>normal! f(vi(<CR>
" Operator motion for In Last ( in line
onoremap il( :<C-u>normal! F)vi(<CR>
" Operator motion for Around Next ( in line
onoremap an( :<C-u>normal! f(va(<CR>
" Operator motion for Around Last ( in line
onoremap al( :<C-u>normal! F)va(<CR>
" Operator motion for In Next { in line
onoremap in{ :<C-u>normal! f{vi{<CR>
" Operator motion for In Last { in line
onoremap il{ :<C-u>normal! F}vi{<CR>
" Operator motion for Around Next { in line
onoremap an{ :<C-u>normal! f{va{<CR>
" Operator motion for Around Last { in line
onoremap al{ :<C-u>normal! F}va{<CR>
