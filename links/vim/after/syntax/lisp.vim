" My lispParen group introduced in the runtime update prior to this patch
if ! has("patch-8.1.1715")
  if ! get(g:, 'lisp_rainbow', v:false)
    " override to make customizing parens easier
    syn region lispList matchgroup=lispParen start="(" skip="|.\{-}|" matchgroup=lispParen end=")" contains=@lispListCluster

    " Default behavior
    hi def link lispParen Delimiter
  endif
endif

syn keyword lispFunc lambda conceal cchar=λ

if ! dracula#should_abort('lisp')
  hi link lispParen DraculaSubtle
endif
