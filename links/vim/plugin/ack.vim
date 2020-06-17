if exists('g:loaded_ack')
  finish
endif

if !executable('ack')
  finish
endif

let &grepprg = 'ack -s --nopager --nocolor --nogroup --with-filename --column'
let &grepformat = '%f:%l:%c:%m,%f:%l:%m'
