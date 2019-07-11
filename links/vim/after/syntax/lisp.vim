if ! get(g:, 'lisp_rainbow', v:false)
  " override to make customizing parens easier
  syn region lispList matchgroup=lispParen start="(" skip="|.\{-}|" matchgroup=lispParen end=")" contains=@lispListCluster

  " Default behavior
  hi def link lispParen Delimiter

  if ! dracula#should_abort('lisp')
    hi link lispParen DraculaSubtle
  endif
endif
