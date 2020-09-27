" magic
" (
  " open bar
  " start search
  " at least 1 keyword, as few as possible
  " close bar
  " end search
" )
" OR
" (
  " '
  " at least 1 keyword, as few as possible
  " '
" )
let g:bk#help#tag_pattern = bk#pattern#join([
      \ '\m',
      \ bk#pattern#branchify([
      \   bk#pattern#group(bk#pattern#join([
      \     '|',
      \     '\zs',
      \     '\k\{-1,}',
      \     '\ze',
      \     '|' ])),
      \   bk#pattern#group(bk#pattern#join([
      \     "'",
      \     '\k\{-1,}',
      \     "'" ]))])])

" modified from github@habamax/.vim/after/ftplugin/help.vim
function! bk#help#goto_link(direction)
  let l:search_flag = get(
        \ {'next': '',
        \  'prev': 'b'},
        \ a:direction,
        \ '')
  call search(g:bk#help#tag_pattern, l:search_flag)
endfunction
