if ! exists(':UndotreeToggle')
  finish
endif

nnoremap <unique> <silent> <Leader>u :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle=1
