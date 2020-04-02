if exists('g:loaded_csearch')
  finish
endif
let g:loaded_csearch = 1

command -count -nargs=+ Csearch
      \ cexpr [] <Bar>
      \ execute printf('%s vimgrep /%s/g %%', <count> > 0 ? <q-count> : '', escape(<q-args>, '/'))
