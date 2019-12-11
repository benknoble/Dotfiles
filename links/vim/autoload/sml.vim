function! sml#load(file) abort
  if empty(a:file)
    return
  endif

  let l:cm = glob(fnamemodify(a:file, ':h').'/*.cm', v:false, v:true)
  if len(l:cm)
    let l:expression = printf("CM.make \"%s\";\n", l:cm[0])
  else
    let l:expression = printf("use \"%s\";\n", a:file)
  endif

  let l:terms = term_list()
  if empty(term_list())
    call terminal#run('++close')
    let l:terms = term_list()
  endif

  let l:term = l:terms[0]
  " double-quotes necessary for \n expansion
  call term_sendkeys(l:term, l:expression)
  let l:win = bufwinnr(l:term)
  exec l:win 'wincmd w'
endfunction
