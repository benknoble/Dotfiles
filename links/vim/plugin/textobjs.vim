for char in [ '_', '.', '/' ]
  if ! hasmapto(printf('i%s', char), 'vo')
    execute printf('xnoremap i%s :<C-u>normal! T%svt%s<CR>', char, char, char)
    execute printf('onoremap i%s :<C-u>normal vi%s<CR>', char, char)
  endif
  if ! hasmapto(printf('a%s', char), 'vo')
    execute printf('xnoremap a%s :<C-u>normal! F%svf%s<CR>', char, char, char)
    execute printf('onoremap a%s :<C-u>normal va%s<CR>', char, char)
  endif
endfor
