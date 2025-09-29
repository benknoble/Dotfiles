vim9script

export def Hyperlink(text: string)
  var z = getreginfo('z')
  try
    normal! mz
    # find the end of the next hyperlink block, if there is one
    search('^\[\d\+\]:', 'W')
    :'}
    execute ':' prevnonblank('.')
    # grab the highest number in the document til this point
    var max = getline(1, '.')->map((idx, line) => matchlist(line, '^\[\(\d\+\)\]:')->get(1, '0')->str2nr())->max()
    var n = max + 1
    # we are "the end of the next hyperlink block, if there is one",
    # which might be the end of the document (but that could be a link line):
    if line('.') == line('$') && getline('.') !~# '^\[\d\+\]:'
      normal! o
    endif
    put =printf('[%d]: %s', n, text)
    if search('^\[\d\+\]:', 'Wn') != 0
      popup_atcursor(':RenumberLinks', {highlight: 'WarningMsg',
        padding: [], border: [], time: 2000, moved: 'any', pos: 'topleft'})
    endif
    execute printf('normal! `za [%d]', n)
  finally
    setreg('z', z)
  endtry
enddef

# note: a very naive pattern. May catch things are not links…
export def RenumberLinks()
  var z = getreginfo('z')
  try
    normal! mz
    while search('\[\d\+\]', 'W') != 0
      execute "normal! \<C-a>"
    endwhile
    normal! `z
  finally
    setreg('z', z)
  endtry
enddef
