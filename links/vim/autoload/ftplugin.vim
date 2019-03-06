" expects a dictionary, possibly containing keys:
"   - 'opts' (list of local options to unset)
"   - 'vars' (list of variables to unlet)
"   - 'commands' (list of commands to delete)
"   - 'maps' (list of lists: [mode, mapped keys])
"      NOTE: mapped keys will be exec'd in double quotes, so <LocalLeader> may
"            need to be inserted literally
"   - 'funcs' (list of functions to delete)
"   - 'custom' (expression that will be concatenated literally)
function! ftplugin#undo(settings)
  let l:undo = get(b:, 'undo_ftplugin', '')
  let l:suffix = ''

  " options
  for option in get(a:settings, 'opts', [])
    let l:suffix .= printf('setlocal %s< | ', option)
  endfor

  " variables
  for var in get(a:settings, 'vars', [])
    let l:suffix .= printf('unlet! %s | ', var)
  endfor

  " commands
  for command in get(a:settings, 'commands', [])
    let l:suffix .= printf('silent! delcommand %s | ', command)
  endfor

  " mappings [mode, key]
  for [mode, key] in get(a:settings, 'maps', [])
    let l:suffix .= printf("execute 'silent! %sunmap <buffer> %s' | ", mode, key)
  endfor

  " functions
  for func in get(a:settings, 'funcs', [])
    let l:suffix .= printf('delfunction! %s | ', func)
  endfor

  for code in get(a:settings, 'custom', [])
    let l:suffix .= printf('%s | ', code)
  endfor

  " eliminate trailing spaces and <Bar>s
  let l:suffix = trim(l:suffix, ' |')

  if ! empty(l:suffix)
    if ! empty(l:undo)
      let l:undo .= ' | ' . l:suffix
    else
      let l:undo = l:suffix
    endif
  endif

  return l:undo
endfunction

" test
" execute the file after uncommenting to verify

" echo ftplugin#undo({
"       \ 'opts': [ 'tw', 'sw', 'sts', ],
"       \ 'vars': [ 'b:interpreter', ],
"       \ 'commands': [ 'USER', ],
"       \ 'maps': [ ['o', 'keys'],
"       \           ['x', 'keys'],
"       \           ['i', 'keys'],
"       \           ['c', 'keys'],
"       \           ['v', 'keys'],
"       \           ['t', 'keys'],
"       \           ['l', 'keys'],
"       \           ['s', 'keys'],
"       \           ['', 'keys'],
"       \           ['n', '<LocalLeader>keys'], ],
"       \ 'funcs': [ 'b:MySpecialFunc', ],
"       \ 'custom': [ 'call MyUndoFunc()' ],
"       \ })
