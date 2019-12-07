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
let s:badwords = [
      \ 'obvious\(ly\)\?',
      \ 'basic\(ally\)\?',
      \ 'simpl\(e\|y\)',
      \ 'of course',
      \ 'clear\(ly\)\?',
      \ 'just',
      \ 'everyone knows',
      \ 'However,',
      \ 'easy',
      \ ]

hi def link Badword ErrorMsg
function s:mark_bad(word) abort
  let l:pattern = printf('/\c%s/', a:word)
  exec 'syn match Badword' l:pattern 'containedin=ALL'
endfunction

augroup Badword
  au!
  au Syntax * for word in get(g:, 'badwords', []) + s:badwords | call s:mark_bad(word) | endfor
augroup END

command Badsearch call feedkeys('/'.join(get(g:, 'badwords', []) + s:badwords, '\|').'<CR>', 'n')
