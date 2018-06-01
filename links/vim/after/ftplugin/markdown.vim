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

" Enable folds
let g:markdown_folding = 1

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

let b:undo_ftplugin .= 'setlocal textwidth< spell< spelllang< iskeyword<'
let b:undo_ftplugin .= " | exe 'nunmap <buffer> <LocalLeader>u1'"
let b:undo_ftplugin .= " | exe 'nunmap <buffer> <LocalLeader>u2'"
let b:undo_ftplugin .= " | exe 'nunmap <buffer> <LocalLeader>u3'"
let b:undo_ftplugin .= " | exe 'ounmap <buffer> ih='"
let b:undo_ftplugin .= " | exe 'ounmap <buffer> ih-'"
let b:undo_ftplugin .= " | exe 'ounmap <buffer> i#1'"
let b:undo_ftplugin .= " | exe 'ounmap <buffer> i#2'"
let b:undo_ftplugin .= " | exe 'ounmap <buffer> i#3'"
