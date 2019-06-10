" TODO consider a range instead?
function! fold#Fold(text, bang) abort
  let l:comment_format =
        \ substitute(&commentstring, '\zs[^\s]\ze%s', '\=submatch(0)." "', '')
  let l:commented_text = printf(l:comment_format, a:text)
  let l:open_fold = commented_text . ' {{{'
  let l:close_fold = commented_text . ' }}}'
  if a:bang is# '!'
    put =l:open_fold
    -1
    join
    +1
    put =l:close_fold
    if line('.') != line('$')
      -1
      join
    endif
  else
    put =l:open_fold
    put =l:close_fold
    -2
    if getline('.') =~# '^\s*$'
      join
    endif
  endif
endfunction
