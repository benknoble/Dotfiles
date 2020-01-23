syn keyword clojureFunc fn conceal cchar=λ
syn keyword clojureFunc partial conceal cchar=$
syn keyword clojureFunc comp conceal cchar=←

if ! dracula#should_abort('clojure')
  hi link clojureParen DraculaSubtle
endif
