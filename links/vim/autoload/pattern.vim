" functions for building patterns
" cf. ":help pattern"

function! pattern#branchify(concats) abort
  return join(a:concats, '\|')
endfunction

function! pattern#group_many(patterns) abort
  return map(copy(a:patterns), 'printf("\\(%s\\)", v:val)')
endfunction

function! pattern#group(pattern) abort
  return pattern#group_many([a:pattern])[0]
endfunction

function! pattern#join(patterns) abort
  return join(a:patterns, '')
endfunction
