" Vim filetype plugin
" Language:              Markdown
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

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

onoremap <buffer> ih= :<C-u>execute "normal! ?^==\\+$\r\rkvg_"<CR>
onoremap <buffer> ih- :<C-u>execute "normal! ?^--\\+$\r\rkvg_"<CR>
onoremap <buffer> i#1 :<C-u>execute "normal! ?^#\\s.?e\r\rvg_"<CR>
onoremap <buffer> i#2 :<C-u>execute "normal! ?^##\\s.?e\r\rvg_"<CR>
onoremap <buffer> i#3 :<C-u>execute "normal! ?^###\\s.?e\r\rvg_"<CR>

xnoremap <LocalLeader>h :call markdown#to_liquid()<CR>
nnoremap <LocalLeader>h :%call markdown#to_liquid()<CR>

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'textwidth',
      \   'spell',
      \   'spelllang',
      \   'iskeyword',
      \ ],
      \ 'maps': [
      \   [ 'n', '<LocalLeader>u1' ],
      \   [ 'n', '<LocalLeader>u2' ],
      \   [ 'n', '<LocalLeader>u3' ],
      \   [ 'o', 'ih=' ],
      \   [ 'o', 'ih-' ],
      \   [ 'o', 'i#1' ],
      \   [ 'o', 'i#2' ],
      \   [ 'o', 'i#3' ],
      \   [ 'x', '<LocalLeader>h'],
      \   [ 'n', '<LocalLeader>h'],
      \ ],
      \ 'vars': [
      \   'g:markdown_folding',
      \ ],
      \ 'funcs': [
      \   'UnderlineHeading',
      \ ],
      \ })
