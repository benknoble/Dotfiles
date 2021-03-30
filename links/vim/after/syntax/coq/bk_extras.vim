syntax match coqSubscript keepend /\K\d\+/ms=s+1 transparent contains=coqSubscriptDigit containedin=ALLBUT,.*Comment,coqRequire,coqSubscript,coqSubscriptDigit
syntax match coqSubscriptDigit /0/ contained conceal cchar=₀
syntax match coqSubscriptDigit /1/ contained conceal cchar=₁
syntax match coqSubscriptDigit /2/ contained conceal cchar=₂
syntax match coqSubscriptDigit /3/ contained conceal cchar=₃
syntax match coqSubscriptDigit /4/ contained conceal cchar=₄
syntax match coqSubscriptDigit /5/ contained conceal cchar=₅
syntax match coqSubscriptDigit /6/ contained conceal cchar=₆
syntax match coqSubscriptDigit /7/ contained conceal cchar=₇
syntax match coqSubscriptDigit /8/ contained conceal cchar=₈
syntax match coqSubscriptDigit /9/ contained conceal cchar=₉

syntax keyword coqType nat containedin=ALLBUT,.*Comment conceal cchar=ℕ
syntax keyword coqType Z containedin=ALLBUT,.*Comment conceal cchar=ℤ
" syntax keyword coqType bool containedin=ALLBUT,.*Comment conceal cchar=𝟚
