" modified from github@habamax/.vim/after/ftplugin/help.vim
function! help#goto_link(direction)
  let l:search_flag = get(
        \ {
        \   'next': '',
        \   'prev': 'b'
        \ },
        \ a:direction,
        \ ''
        \ )
  " magic
  " open bar
  " start search
  " at least 1 non-space, as few as possible
  " close bar
  let l:search_pattern = pattern#join(
        \ [ '\m',
        \   '|',
        \   '\zs',
        \   '\S\{-1,}',
        \   '|'
        \ ])
  call search(l:search_pattern, l:search_flag)
endfunction
