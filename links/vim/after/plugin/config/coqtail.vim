if ! (&rtp =~# 'coqtail')
  finish
endif

let g:coqtail_nomap = v:true
let g:coqtail_map_prefix = '<localleader>c'

function g:CoqtailHighlight() abort
  highlight link CoqtailSent IncSearch
  highlight link CoqtailChecked CursorLine
endfunction
