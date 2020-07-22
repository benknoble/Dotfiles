if exists('g:loaded_rg')
  finish
endif

if !executable('rg')
  finish
endif

let &grepprg = 'rg --vimgrep'
let &grepformat = '%f:%l:%c:%m,%f:%l:%m'
