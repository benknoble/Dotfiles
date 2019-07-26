if exists('g:loaded_syntoggle')
  finish
endif
let g:loaded_syntoggle = 1

command! SynToggle if exists("g:syntax_on") <Bar>
      \   syntax off <Bar>
      \ else <Bar>
      \   syntax enable <Bar>
      \ endif
