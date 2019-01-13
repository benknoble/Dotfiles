" Vim filetype plugin
" Language:              Markdown
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

" Wrap at 80 characters
setlocal textwidth=80
" Spell check on
setlocal spell spelllang=en_us

" Remove underscore from iskeyword
setlocal iskeyword-=_

function! UnderlineHeading(level)
  if a:level == 1
    normal! yypVr=
  elseif a:level == 2
    normal! yypVr-
  else
    execute "normal! I### "
  endif
endfunction

nnoremap <buffer> <LocalLeader>u1 :call UnderlineHeading(1)<CR>
nnoremap <buffer> <LocalLeader>u2 :call UnderlineHeading(2)<CR>
nnoremap <buffer> <LocalLeader>u3 :call UnderlineHeading(3)<CR>

onoremap <buffer> ih= :<C-u>execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<CR>
onoremap <buffer> ih- :<C-u>execute "normal! ?^--\\+$\r:nohlsearch\rkvg_"<CR>
onoremap <buffer> i#1 :<C-u>execute "normal! ?^#\\s.?e\r:nohlsearch\rvg_"<CR>
onoremap <buffer> i#2 :<C-u>execute "normal! ?^##\\s.?e\r:nohlsearch\rvg_"<CR>
onoremap <buffer> i#3 :<C-u>execute "normal! ?^###\\s.?e\r:nohlsearch\rvg_"<CR>

if !exists("*MyMarkdownFtpluginUndo")
  function MyMarkdownFtpluginUndo()
    setlocal textwidth<
    setlocal spell<
    setlocal spelllang<
    setlocal iskeyword<

    unlet! g:markdown_folding


    silent! ounmap <buffer> i#3
    silent! ounmap <buffer> i#2
    silent! ounmap <buffer> i#1
    silent! ounmap <buffer> ih-
    silent! ounmap <buffer> ih=
    silent! nunmap <buffer> <LocalLeader>u3
    silent! nunmap <buffer> <LocalLeader>u2
    silent! nunmap <buffer> <LocalLeader>u1

  endfunction
endif

let b:undo_ftplugin .= 'call MyMarkdownFtpluginUndo()'
