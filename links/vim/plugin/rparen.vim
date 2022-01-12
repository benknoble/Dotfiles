if exists('g:loaded_rparen')
  finish
endif
let g:loaded_rparen = 1

inoremap <expr> ] rparen#MatchingParenType()
inoremap <expr> ) rparen#MatchingParenType()
inoremap <expr> } rparen#MatchingParenType()
