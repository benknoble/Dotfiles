function! markdown#Folds() abort
  if s:IsFenced(v:lnum)
    return "="
  endif
  let thisline = getline(v:lnum)
  if match(thisline, '^###') >= 0
      return ">3"
  elseif match(thisline, '^##') >= 0
    return ">2"
  elseif match(thisline, '^#') >= 0
    return ">1"
  else
    return "="
  endif
endfunction

function! markdown#FoldText() abort
  let foldsize= (v:foldend-v:foldstart)
  return getline(v:foldstart) . ' (' . foldsize . ' lines )'
endfunction

function! s:IsFenced(lnum) abort
  let syntaxgroup = map(synstack(a:lnum,1), 'synIDattr(v:val, "name")')
  return index(syntaxgroup, 'markdownCode') >= 0
endfunction
