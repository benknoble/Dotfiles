" Vim filetype plugin
" Language              Markdown
" Maintainer            Ben Knoble <ben.knoble@gmail.com>

" Wrap at 80 characters
setlocal textwidth=80
" Spell check on
setlocal spell spelllang=en_us

function! UnderlineHeading(level)
  if a:level == 1
    normal! yypVr=
  elseif a:level == 2
    normal! yypVr-
  else
    execute "normal! I### "
  endif
endfunction

nnoremap <LocalLeader>u1 :call UnderlineHeading(1)<CR>
nnoremap <LocalLeader>u2 :call UnderlineHeading(2)<CR>
nnoremap <LocalLeader>u3 :call UnderlineHeading(3)<CR>
