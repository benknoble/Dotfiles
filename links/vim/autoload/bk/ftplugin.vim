" expects a dictionary, possibly containing keys:
"   - 'opts' (list of local options to unset)
"   - 'vars' (list of variables to unlet)
"   - 'commands' (list of commands to delete)
"   - 'maps' (list of lists: [mode, mapped keys])
"      NOTE: mapped keys will be exec'd in double quotes, so <LocalLeader> may
"            need to be inserted literally
"   - 'abbrevs' (like maps, but for abbreviations)
"   - 'funcs' (list of functions to delete)
"   - 'custom' (expression that will be concatenated literally)
function! bk#ftplugin#undo(settings, ...)
  const l:name = a:0 > 0 ? a:1 : 'undo_ftplugin'
  let l:undo = get(b:, l:name, '')
  let l:suffix = []

  " options
  call extend(
        \ l:suffix,
        \ map(
        \   get(a:settings, 'opts', []),
        \   "printf('setlocal %s<', v:val)"))

  " variables
  call extend(
        \ l:suffix,
        \ map(
        \   get(a:settings, 'vars', []),
        \   "printf('unlet! %s', v:val)"))

  " commands
  call extend(
        \ l:suffix,
        \ map(
        \   get(a:settings, 'commands', []),
        \   "printf('silent! delcommand %s', v:val)"))

  " mappings [mode, key]
  call extend(
        \ l:suffix,
        \ map(
        \   get(a:settings, 'maps', []),
        \   "printf('execute \"silent! %sunmap <buffer> %s\"', v:val[0], escape(v:val[1], \"'\"))"))

  " abbreviations [mode, key]
  call extend(
        \ l:suffix,
        \ map(
        \   get(a:settings, 'abbrevs', []),
        \   "printf('execute \"silent! %sunabbrev <buffer> %s\"', v:val[0], escape(v:val[1], \"'\"))"))

  " functions
  call extend(
        \ l:suffix,
        \ map(
        \   get(a:settings, 'funcs', []),
        \   "printf('delfunction! %s', v:val)"))

  " custom code
  call extend(
        \ l:suffix,
        \ get(a:settings, 'custom', []))

  let l:to_append = join(l:suffix, ' | ')

  if ! empty(l:to_append)
    if ! empty(l:undo)
      let l:undo .= ' | ' . l:to_append
    else
      let l:undo = l:to_append
    endif
  endif

  return l:undo
endfunction

" test
" execute the file after uncommenting to verify

" echo bk#ftplugin#undo({
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
"       \ 'abbrevs': [ ['i', '#i'] ],
"       \ 'funcs': [ 'b:MySpecialFunc', ],
"       \ 'custom': [ 'call MyUndoFunc()' ],
"       \ })
