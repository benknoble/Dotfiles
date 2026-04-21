if ! (&rtp =~# 'coqtail')
  finish
endif

let g:coqtail_noimap = v:true
let g:coqtail_map_prefix = '<localleader>c'

function g:CoqtailHighlight() abort
  highlight link CoqtailSent IncSearch
  highlight link CoqtailChecked CursorLine
endfunction

" see after/ftplugin/coq.vim
function CoqtailHookDefineMappings() abort
  silent! nunmap <buffer> <localleader>cj
  silent! nunmap <buffer> <localleader>ck
  nmap <buffer> ) <Plug>RocqNext
  nmap <buffer> ( <Plug>RocqUndo

  silent! nunmap <buffer> <localleader>cl
  nmap <buffer> gl <Plug>RocqToLine

  silent! nunmap <buffer> <localleader>cG
  nmap <buffer> g. <Plug>RocqJumpToEnd
endfunction
