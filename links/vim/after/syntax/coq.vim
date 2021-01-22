" fix awkward highlights
highlight link coqTerm Keyword
highlight link coqIndConstructor Keyword
highlight link coqNotationString String

" unicode symbols
syntax match coqKwd contained "∧\|∨\|→\|↔\|λ\|∀\|∃"
syntax match coqProofKwd contained "∧\|∨\|→\|↔\|λ\|∀\|∃"
syntax match coqLtac contained "λ"
syntax match coqTactic contained "∃"
