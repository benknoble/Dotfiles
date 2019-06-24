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
  let l:suffix = []

  " options
  call extend(
        \ l:suffix,
        \ map(
        \   get(a:settings, 'opts', []),
        \   {_,opt -> printf('setlocal %s<', opt)}))

  " variables
  call extend(
        \ l:suffix,
        \ map(
        \   get(a:settings, 'vars', []),
        \   {_,var -> printf('unlet! %s', var)}))

  " commands
  call extend(
        \ l:suffix,
        \ map(
        \   get(a:settings, 'commands', []),
        \   {_,command -> printf('silent! delcommand %s', command)}))

  " mappings [mode, key]
  call extend(
        \ l:suffix,
        \ map(
        \   get(a:settings, 'maps', []),
        \   {_,map -> printf("execute 'silent! %sunmap <buffer> %s'",
        \                                     map[0],          map[1])}))

  " functions
  call extend(
        \ l:suffix,
        \ map(
        \   get(a:settings, 'funcs', []),
        \   {_,func -> printf('delfunction! %s', func)}))

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

" expected output
"""""""""""""""""
" call VimFtpluginUndo() | setlocal shiftwidth< | setlocal softtabstop< | setlocal keywordprg< | execute 'silent! nunmap <buffer> <LocalLeader>el' | execute 'silent! nunmap <buffer> <LocalLeader>ef'|setlocal path= suffixesadd= includeexpr= include= define= keywordprg=|sil! delcommand Breakadd|sil! delcommand Breakdel|sil! exe "nunmap <buffer> K" | setlocal tw< | setlocal sw< | setlocal sts< | unlet! b:interpreter | silent! delcommand USER | execute 'silent! ounmap <buffer> keys' | execute 'silent! xunmap <buffer> keys' | execute 'silent! iunmap <buffer> keys' | execute 'silent! cunmap <buffer> keys' | execute 'silent! vunmap <buffer> keys' | execute 'silent! tunmap <buffer> keys' | execute 'silent! lunmap <buffer> keys' | execute 'silent! sunmap <buffer> keys' | execute 'silent! unmap <buffer> keys' | execute 'silent! nunmap <buffer> <LocalLeader>keys' | delfunction! b:MySpecialFunc | call MyUndoFunc()
