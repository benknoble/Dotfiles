function! tex#section(name) abort
  let l:label = substitute(a:name, '\s', '_', 'g')
  let l:result =  printf('\section{%s}\label{S:%s} %%Section~\ref{S:%s}',
        \ a:name,
        \ l:label,
        \ l:label)
  return l:result
endfunction
