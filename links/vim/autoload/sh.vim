" sh functions

" Text object for shell parameter expansions
" Based on https://vimways.org/2018/transactions-pending/
" Definitions:
"   Parameter: An entity that stores values. It can be a name, a number, or one
"   of the special characters listed below. A variable is a parameter denoted by
"   a name.
"   Name: A word consisting solely of letters, numbers, and underscores, and
"   beginning with a letter or underscore. Names are used as shell variable and
"   function names. Also referred to as an identifier.
"   Positional Parameters: Any parameter denoted by one or more digits. Those
"   with multiple digits require braces.
"   Special Parameters: The following list:
"     - *
"     - @
"     - #
"     - ?
"     - -
"     - $
"     - !
"     - 0
"     - _
"  Expansion: Any usage of a parameter's value in place of its name: the common
"  forms include $var and ${var}. The more 'esoteric' options are documented
"  under 'Parameter Expansion' in bash(1).
"
"  In general, one wants to select the entire expansion construct in order to
"  e.g. surround in quotes (a common idiom). This means:
"    - $
"    - a parameter (name or special); or,
"    - a brace construction:
"      - {
"      - !, optionally                               -+
"      - parameter (name or special)                  |-basically 'anything'
"      - an expansion option (see above), optionally -+
"      - }
"
"  In the case of the braces, we can simply select the ${...}. Sans braces, we
"  have to match exactly the definition of a parameter. We construct a regex for
"  this purpose.

function! s:branchify_atoms(atoms) abort
  return join(a:atoms, '\|')
endfunction

function! s:group_atoms(atoms) abort
  return map(copy(a:atoms), 'printf("\\(%s\\)", v:val)')
endfunction

function! s:group_atom(atom) abort
  return s:group_atoms([a:atom])[0]
endfunction

function! s:concat_atoms(atoms) abort
  return join(a:atoms, '')
endfunction

" matches a name (no braces)
" magic mode
" begins with alpha or underscore
" letters, numbers, underscores
let s:name_pattern = s:concat_atoms(
      \ ['\m',
      \  s:group_atom(
      \    s:branchify_atoms([ '\a',
      \                        '_' ])),
      \  s:group_atom(
      \    s:branchify_atoms([ '\a',
      \                        '\d',
      \                        '_' ])),
      \  '*'])

" matches a positional parameter (no braces)
" magic
" a single digit
let s:positional_pattern = s:concat_atoms(
      \ ['\m',
      \ '[1-9]'])

" matches any of the special parameters (no braces)
" magic
" special params as branches
let s:special_pattern = s:concat_atoms(
      \ ['\m',
      \  s:branchify_atoms(
      \    ['\*',
      \     '@',
      \     '#',
      \     '?',
      \     '-',
      \     '\$',
      \     '!',
      \     '0',
      \     '_'])])


" matches a parameter (non-brace)
" magic
" name or positional or special
let s:parameter_pattern = s:concat_atoms(
      \ ['\m',
      \  s:branchify_atoms(
      \    s:group_atoms(
      \      [s:name_pattern, s:positional_pattern, s:special_pattern]))])

" matches anything in braces
" magic
" opening brace
" anything, but non-greedy: there may be two braces in one line
" closing brace
let s:brace_pattern = s:concat_atoms(
      \ ['\m',
      \  '{',
      \  '.\{-}',
      \  '}'])

" matches a $ followed by a parameter or a brace construction
" magic
" literal '$'
" parameter or brace
let s:expansion_pattern = s:concat_atoms(
      \ ['\m',
      \  '\$',
      \  s:group_atom(
      \    s:branchify_atoms(
      \      s:group_atoms(
      \        [s:parameter_pattern, s:brace_pattern])))])

function! sh#in_parameter_expansion() abort
  let l:line = line('.')
  if !search(s:expansion_pattern, 'ce', l:line)
    return
  endif
  normal! v
  call search(s:expansion_pattern, 'cb', l:line)
endfunction

" Text object for subshell stuff: $( ... )
" magic
" literal '$'
" open paren
" anything (doesn't handle nesting well)
" closing paren
let s:subshell_begin_pattern = s:concat_atoms(
      \ ['\m',
      \  '\$',
      \  '('])

function! sh#in_subshell() abort
  let l:line = line('.')
  if !search(s:subshell_begin_pattern, 'cb', l:line)
    return
  endif
  " start visual mode on the '$'
  " find the opening paren
  " find its closing paren
  normal! vf(%
endfunction
