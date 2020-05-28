if exists('g:loaded_badwords')
  finish
endif
let g:loaded_badwords = 1

" obvious obviously
" basic basically
" simple simply
" of course
" clear clearly
" just
" everyone knows
" However,
" easy
" utilize utilized utilization utilizes
let s:badwords = [
      \ '\<obvious\(ly\)\?\>',
      \ '\<basic\(ally\)\?\>',
      \ '\<simpl\(e\|y\)\>',
      \ '\<of course\>',
      \ '\<clear\(ly\)\?\>',
      \ '\<just\>',
      \ '\<everyone knows\>',
      \ '\<However\>,',
      \ '\<easy\>',
      \ '\<utiliz\(e\w\?\|ation\)\>',
      \ ]

hi def link Badword ErrorMsg
function s:mark_bad(word) abort
  let l:pattern = printf('/\c%s/', a:word)
  exec 'syn match Badword' l:pattern 'containedin=ALL'
endfunction

augroup Badword
  autocmd!
  autocmd Syntax * for word in get(g:, 'badwords', []) + s:badwords | call s:mark_bad(word) | endfor
augroup END

command -bang -nargs=? -complete=file Badsearch
      \ execute 'vimgrep'
      \ '/'.join(get(g:, 'badwords', []) + s:badwords, '\|').'/'.(<bang>0 ? 'g' : '')
      \ (empty(<q-args>) ? expand('%') : <q-args>)
