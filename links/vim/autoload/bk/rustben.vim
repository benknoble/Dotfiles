function bk#rustben#make_test() abort
  if getline('.') !~# '\<fn\>'
    ?\<fn\>
  endif
  normal! O#[test]
endfunction

function bk#rustben#includeexpr(fname) abort
  " Remove leading 'crate::' to deal with 2018 edition style 'use' statements
  let l:fname = substitute(a:fname, '^crate::', '', '')

  " Remove trailing colons arising from lines like
  "
  "     use foo::{Bar, Baz};
  let l:fname = substitute(l:fname, ':\+$', '', '')

  " Replace '::' with '/'
  let l:fname = substitute(l:fname, '::', '/', 'g')

  " When we have
  "
  "    use foo::bar::baz;
  "
  " we can't tell whether baz is a module or a function; and we can't tell
  " which modules correspond to files.
  "
  " So we work our way up, trying
  "
  "     foo/bar/baz.rs
  "     foo/bar.rs
  "     foo.rs
  while l:fname !=# '.'
    let l:path = findfile(l:fname)
    if !empty(l:path)
      return l:fname
    endif
    let l:fname = fnamemodify(l:fname, ':h')
  endwhile
  return l:fname
endfunction
