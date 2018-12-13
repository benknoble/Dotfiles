if ! exists(':PresentingStart')
  finish
endif

let g:presenting_top_margin = 2
let g:presenting_statusline =
      \ '%{b:presenting_page_current}/%{b:presenting_page_total} (%l/%L, %c) %y'
