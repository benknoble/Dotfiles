syn keyword clojureSpecial fn conceal cchar=λ

" matches have lower priority than keywords, so I have to start the match
" earlier to get priority

" syn match clojureLambdaConceal /\_.\<fn\>/ containedin=ALL
" syn match clojureLamConceal /f/ contained containedin=clojureLambdaConceal conceal cchar=λ
" syn match clojureBdaConceal /n/ contained containedin=clojureLambdaConceal conceal cchar=.
" hi link clojureFnConceal clojureSpecial

syn keyword clojureFunc partial conceal cchar=$
syn keyword clojureFunc comp conceal cchar=←

syn keyword clojureMacro and conceal cchar=∧
syn keyword clojureMacro or conceal cchar=∨

if ! dracula#should_abort('clojure')
  hi link clojureParen DraculaSubtle
endif
