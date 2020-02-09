if ! exists(':Vifm')
  finish
endif

let g:vifm_embed_term = v:true
let g:vifm_embed_split = v:true

command! -bar -count -nargs=* -complete=dir Explore
      \ let old_split = get(g:, 'vifm_embed_split', 0) |
      \ let g:vifm_embed_split = 0 |
      \ <count>Vifm <args> |
      \ let g:vifm_embed_split = old_split |
      \ unlet old_split
" note that Vifm refuses to split if the current buffer has no name
command! -bar -count -nargs=* -complete=dir Vexplore vert <count>VsplitVifm <args>
command! -bar -count -nargs=* -complete=dir Sexplore <count>SplitVifm <args>
command! -bar -count -nargs=* -complete=dir Texplore tab <count>TabVifm <args>
