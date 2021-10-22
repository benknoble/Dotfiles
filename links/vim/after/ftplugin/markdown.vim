" Vim filetype plugin
" Language:              Markdown
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" Wrap at 80 characters
setlocal textwidth=80
" Spell check on
setlocal spell spelllang=en_us

" Remove underscore from iskeyword
setlocal iskeyword-=_

nnoremap <buffer> <expr> <LocalLeader>u bk#markdown#heading()

onoremap <buffer> ih= :<C-u>execute "normal! ?^==\\+$\r\rkvg_"<CR>
onoremap <buffer> ih- :<C-u>execute "normal! ?^--\\+$\r\rkvg_"<CR>
onoremap <buffer> i#1 :<C-u>execute "normal! ?^#\\s.?e\r\rvg_"<CR>
onoremap <buffer> i#2 :<C-u>execute "normal! ?^##\\s.?e\r\rvg_"<CR>
onoremap <buffer> i#3 :<C-u>execute "normal! ?^###\\s.?e\r\rvg_"<CR>

xnoremap <buffer> <LocalLeader>h :call bk#markdown#to_liquid()<CR>
nnoremap <buffer> <LocalLeader>h :%call bk#markdown#to_liquid()<CR>

command -buffer -bar Navigate call bk#markdown#navigate()
nnoremap <buffer> <Localleader>n :Navigate<CR>

let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ opts: [
      \   'textwidth',
      \   'spell',
      \   'spelllang',
      \   'iskeyword',
      \ ],
      \ maps: [
      \   [ 'n', '<LocalLeader>u' ],
      \   [ 'o', 'ih=' ],
      \   [ 'o', 'ih-' ],
      \   [ 'o', 'i#1' ],
      \   [ 'o', 'i#2' ],
      \   [ 'o', 'i#3' ],
      \   [ 'x', '<LocalLeader>h' ],
      \   [ 'n', '<LocalLeader>h' ],
      \   [ 'n', '<Localleader>n' ],
      \ ],
      \ commands: [
      \   'Navigate',
      \ ],
      \ })
