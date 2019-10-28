function! lisp#load(file) abort
  if empty(a:file)
    return
  endif

  let l:terms = term_list()
  if empty(term_list())
    call terminal#run('++close')
    let l:terms = term_list()
  endif

  let l:term = l:terms[0]
  " double-quotes necessary for \n expansion
  call term_sendkeys(l:term, printf("(load #P\"%s\")\n", a:file))
  let l:win = bufwinnr(l:term)
  exec l:win 'wincmd w'
endfunction
