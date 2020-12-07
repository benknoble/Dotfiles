syntax keyword racketSyntax lambda conceal cchar=λ
" syntax keyword clojureFunc partial conceal cchar=$
syntax keyword racketFunc compose conceal cchar=←
syntax keyword racketFunc compose1 conceal cchar=←

syntax keyword racketSyntax and conceal cchar=∧
syntax keyword racketSyntax or conceal cchar=∨

if ! dracula#should_abort('racket') || ! dracula_pro#should_abort('racket')
  highlight link racketParen DraculaSubtle
endif
