let s:header_pattern = '\v\[.*\]'

function! bk#gitconfig#man(line) abort
  if a:line =~# s:header_pattern
    let @/ = printf('\m^\s*\zs%s\.', trim(a:line, '[]'))
  else
    let sect_line = search(s:header_pattern, 'bnW')
    let header = trim(trim(getline(sect_line), '[]'))
    if stridx(header, '"') >= 0
      let header = trim(substitute(header, '".*"', '', ''))
      let header .= '\.<.*>'
    endif
    let var = trim(substitute(a:line, '=.*', '', ''))
    let @/ = printf('\m^\s*\.\?\zs%s\.%s\.\?', header, var)
  endif
  " open the man page
  if !exists(':Man')
    runtime! ftplugin/man.vim
  endif
  Man git-config
  normal! n
endfunction
