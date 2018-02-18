" Show the highlight groups under the cursor
" Maintainer:       David Ben Knoble <ben.knoble@gmail.com>
" Last Change:      2018 Feb 18

function! s:SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

nnoremap <Leader><Leader>s :call <SID>SynStack()<CR>
