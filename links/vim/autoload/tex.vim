function! tex#section(name) abort
  let l:label = substitute(a:name, '\s', '_', 'g')
  let l:result =  printf('\section{%s}\label{S:%s} %%Section~\ref{S:%s}',
        \ a:name,
        \ l:label,
        \ l:label)
  return l:result
endfunction

function! tex#inline() abort
  let l:open_pattern = pattern#join(['\m', '\\', '('])
  let l:close_pattern = pattern#join(['\m', '\\', ')'])
  let l:open_pos = searchpos(l:open_pattern, 'bn')
  let l:close_pos = searchpos(l:close_pattern, 'bn')
  if pos#before(l:open_pos, l:close_pos)
    return '\('
  else
    return '\)'
  endif
endfunction
