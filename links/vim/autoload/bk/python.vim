function bk#python#search_tools() abort
  let buf = bufnr()
  call timer_start(500, {_ -> s:set_interpreter(buf)})
endfunction

function s:set_interpreter(buf) abort
  if !empty(findfile('Pipfile', '.;~'))
    call setbufvar(a:buf, 'interpreter', 'pipenv run python3')
  endif
  if !empty(findfile('poetry.lock', '.;~'))
    call setbufvar(a:buf, 'interpreter', 'poetry run python3')
  endif
endfunction
