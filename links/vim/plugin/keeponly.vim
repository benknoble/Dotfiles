if exists('g:keeponly')
  finish
endif
let g:keeponly = 1

function s:keeponly(bang) abort
  for l:arg in argv()
    if l:arg != @%
      execute 'argdelete' arg
    endif
  endfor
  if ! empty(a:bang)
    for l:buf in map(copy(getbufinfo({'buflisted':1})), {k,v -> v.name})
      if l:buf != @%
        execute 'bdelete' l:buf
      endif
    endfor
  endif
endfunction

command -bar -bang KeepOnly call <SID>keeponly(<q-bang>)
