" searchpairpos() timeout in milliseconds
let s:paren_search_timeout = 50

" set to line("w0") to search to top of screen
" set to 1 to search to top of file
let s:paren_search_top = 1

function rparen#MatchingParenType()
  " taken from Bram Moolenaar's `matchparen.vim`
  if !has("syntax") || !exists("g:syntax_on")
    let skip = "0"
  else
    let skip = '!empty(filter(map(synstack(line("."), col(".")), ''synIDattr(v:val, "name")''), ' .
          \ '''v:val =~? "string\\|character\\|singlequote\\|escape\\|symbol\\|comment"''))'
    try
      execute 'if' skip '| let skip = "0" | endif'
    catch /^Vim\%((\a\+)\)\=:E363/
      " pattern uses more memory than 'maxmempattern'
      return
    endtry
  endif

  let s:parenOfs = {} " using s: here so we can access it in the lambda below
  let parens = []

  for delims in split(&matchpairs, ',')
    let [left, right] = split(delims, ':')
    let parens += [right]

    let [line, col] = searchpairpos('\M'.left, '', '\M'.right, 'nbW', skip,
          \ s:paren_search_top, s:paren_search_timeout)
    let ofs = line2byte(line) + col
    let s:parenOfs[right] = ofs
  endfor

  eval parens->sort({lhs, rhs -> s:parenOfs[rhs] - s:parenOfs[lhs]})
  return parens[0]
endfunction
