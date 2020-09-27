" functions for building patterns
" cf. ":help pattern"

function! bk#pattern#branchify(concats) abort
  return join(a:concats, '\|')
endfunction

function! bk#pattern#group_many(patterns) abort
  return map(copy(a:patterns), 'printf("\\(%s\\)", v:val)')
endfunction

function! bk#pattern#group(pattern) abort
  return bk#pattern#group_many([a:pattern])[0]
endfunction

function! bk#pattern#join(patterns) abort
  return join(a:patterns, '')
endfunction
