function bk#dafny#assert_exists_to_statement() abort
  " assert exists x :: P(x);
  " into
  " var x :| P(x);

  " assert (exists x :: P(x));
  " into
  " var x :| P(x);

  " assert exists x, y :: x != y && P(x) ==> P(y);
  " into
  " var x, y :| x != y && P(x) ==> P(y);

  substitute/(\(exists.*\));/\1;/e
  substitute/assert exists/var/
  substitute/::/:|/
endfunction

function bk#dafny#switch_forall_type() abort
  " forall x :: P(x) ==> Q(x)
  " ↕
  " forall x | P(x) :: Q(x)
  if getline('.') =~# '==>'
    substitute/::/|/
    substitute/==>/::/
  else
    substitute/::/==>/
    substitute/|/::/
  endif
endfunction

function bk#dafny#assert_forall_to_statement() abort
  " assert forall x | P(x) :: Q(x);
  " into
  " forall x | P(x) ensures Q(x) {
  "   if P(x) {
  "     assert Q(x);
  "   }
  " }

  " assert (forall x | P(x) :: Q(x));
  " into
  " forall x | P(x) ensures Q(x) {
  "   if P(x) {
  "     assert Q(x);
  "   }
  " }

  if getline('.') =~# '==>' && getline('.') =~# '::.*==>'
    call bk#dafny#switch_forall_type()
  endif
  substitute/(\(forall.*\));/\1;/e
  substitute/assert\s\?//
  substitute/::/ensures/
  substitute/;/ {\r}/
  const old_amark = getpos("'a")
  " want cursor column too
  normal! ma
  ?forall
  const matches = matchlist(getline('.'), '^\s*forall.*|\s*\(.\{-}\)\s\+ensures\s\+\(.*\) {')
  const P = matches[1]
  const Q = matches[2]
  const lines =
        \ [ printf("if %s {", P),
        \   printf("assert %s;", Q),
        \   "}"]
  put =lines
  normal! `a=%
  call setpos("'a", old_amark)
endfunction

function bk#dafny#assert_to_statement() abort
  if getline('.') =~# 'forall'
    call bk#dafny#assert_forall_to_statement()
  elseif getline('.') =~# 'exists'
    call bk#dafny#assert_exists_to_statement()
  endif
endfunction

function bk#dafny#ensures_forall_to_requires_ensures() abort
  " ensures forall x :: P(x) ==> Q(x)
  " into
  " ensures P(x)
  " requires Q(x)
  if getline('.') =~# 'forall.*|.*::'
    call bk#dafny#switch_forall_type()
  endif
  substitute/^ensures\s\+forall.*::\s\+//
  substitute/^\s*\(.\{-}\)\s*==>\s*\(.*\)/requires \1\rensures \2/
  normal! =k
endfunction
