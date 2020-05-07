" syn keyword clojureSpecial fn conceal cchar=λ
" matches have lower priority than keywords, so I have to reset the
" clojureSpecial keyword list:
syn clear clojureSpecial
syn keyword clojureSpecial . clojure.core/let clojure.core/loop def do if let loop monitor-enter monitor-exit new quote recur set! var
syn match clojureFnConceal /fn\@=/ conceal cchar=λ
syn match clojureFnConceal /f\@<=n/ conceal cchar=.
hi link clojureFnConceal clojureSpecial

syn keyword clojureFunc partial conceal cchar=$
syn keyword clojureFunc comp conceal cchar=←

syn keyword clojureMacro and conceal cchar=∧
syn keyword clojureMacro or conceal cchar=∨

if ! dracula#should_abort('clojure')
  hi link clojureParen DraculaSubtle
endif
