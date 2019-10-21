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
let g:help#tag_pattern = pattern#join([
      \ '\m',
      \ pattern#branchify([
      \   pattern#group(pattern#join([
      \     '|',
      \     '\zs',
      \     '\k\{-1,}',
      \     '\ze',
      \     '|' ])),
      \   pattern#group(pattern#join([
      \     "'",
      \     '\k\{-1,}',
      \     "'" ]))])])

" modified from github@habamax/.vim/after/ftplugin/help.vim
function! help#goto_link(direction)
  let l:search_flag = get(
        \ {'next': '',
        \  'prev': 'b'},
        \ a:direction,
        \ '')
  call search(g:help#tag_pattern, l:search_flag)
endfunction
