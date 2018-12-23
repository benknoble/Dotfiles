" Based on https://vimways.org/2018/transactions-pending/

" Text object for shell parameter expansions
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

function! s:branchify_atoms(atoms)
  return join(a:atoms, '\|')
endfunction

function! s:group_atoms(atoms)
  return map(copy(a:atoms), 'printf("\\(%s\\)", v:val)')
endfunction

" matches a name (no braces)
let s:name_pattern = '\m' " magic mode
let s:name_pattern .= s:group_atoms(
      \ [s:branchify_atoms([ '\a', '_' ])]
      \ )[0] " begins with alpha or underscore
let s:name_pattern .= s:group_atoms(
      \ [s:branchify_atoms([ '\a', '\d', '_' ])]
      \ )[0] . '*' " letters, numbers, underscores

" matches a positional parameter (no braces)
let s:positional_pattern = '\m' " magic
let s:positional_pattern .= '[1-9]' " a single digit

" matches any of the special parameters (no braces)
let s:special_pattern = '\m' " magic
let s:special_pattern .= s:branchify_atoms(
      \ [
      \ '\*',
      \ '@',
      \ '#',
      \ '?',
      \ '-',
      \ '\$',
      \ '!',
      \ '0',
      \ '_'
      \ ]
      \ ) " special params as branches

let s:parameter_pattern = '\m' " magic
let s:parameter_pattern .= s:branchify_atoms(
      \ s:group_atoms(
      \   [s:name_pattern, s:positional_pattern, s:special_pattern]
      \   )
      \ )

" matches anything in braces
let s:brace_pattern = '\m' " magic
let s:brace_pattern .= '{' " opening brace
let s:brace_pattern .= '.\{-}' " anything, but non-greedy: there may be two braces in one line
let s:brace_pattern .= '}' " closing brace

" matches a $ followed by a parameter or a brace construction
let s:expansion_pattern = '\m' " magic
let s:expansion_pattern .= '\$' " literal '$'
let s:expansion_pattern .= s:group_atoms(
      \ [s:branchify_atoms(
      \   s:group_atoms(
      \     [s:parameter_pattern, s:brace_pattern]
      \     )
      \   )]
      \ )[0] " extract the one and only element

function! sh#in_parameter_expansion() abort
  let l:line = line('.')
  if !search(s:expansion_pattern, 'ce', l:line)
    return
  endif
  normal! v
  call search(s:expansion_pattern, 'cb', l:line)
endfunction
