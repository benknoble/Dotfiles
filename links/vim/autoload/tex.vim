function! tex#section(name) abort
  let l:result =  printf('\section{%s}\label{S:%s} %%Section~\ref{S:%s}',
        \ a:name,
        \ a:name,
        \ a:name)
  return l:result
endfunction
