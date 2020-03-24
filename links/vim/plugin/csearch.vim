if exists('g:loaded_csearch')
  finish
endif
let g:loaded_csearch = 1

command -nargs=+ Csearch
      \ cexpr [] <Bar>
      \ execute 'global' printf('/%s/', escape(<q-args>, '/')) 'caddexpr printf("%s:%d:%s", expand("%"), line("."), getline("."))'
