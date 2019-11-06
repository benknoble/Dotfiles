if ! exists(':UndotreeToggle')
  finish
endif

nnoremap <unique> <Leader>u :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle=1
