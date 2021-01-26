function bk#notepad#make() abort
  nnoremap <buffer> <localleader>d :call bk#notepad#move_tomorrow_to_today()<CR>
  nnoremap <buffer> <localleader>t :call bk#notepad#move_to_tomorrow()<CR>
  nnoremap <buffer> <localleader>w :call bk#notepad#move_to_weekend()<CR>
  xnoremap <buffer> <localleader>t :call bk#notepad#move_to_tomorrow()<CR>
  xnoremap <buffer> <localleader>w :call bk#notepad#move_to_weekend()<CR>
  setlocal suffixesadd+=.md
  setlocal bufhidden=unload
  let b:undo_ftplugin = bk#ftplugin#undo(#{
        \ opts: [
        \   'suffixesadd',
        \   'bufhidden',
        \ ],
        \ maps: [
        \   ['n', '<localleader>d'],
        \   ['n', '<localleader>t'],
        \   ['n', '<localleader>w'],
        \   ['x', '<localleader>t'],
        \   ['x', '<localleader>w'],
        \ ],
        \ })
endfunction

function bk#notepad#move_to_weekend() range abort
  let view = winsaveview()
  execute a:firstline ',' a:lastline 'move /This Weekend//^$/-'
  call winrestview(view)
endfunction

function bk#notepad#move_to_tomorrow() range abort
  let view = winsaveview()
  execute a:firstline ',' a:lastline 'move /Tomorrow//^$/-'
  call winrestview(view)
endfunction

function bk#notepad#move_tomorrow_to_today() abort
  /Tomorrow/
  +2,/^$/- move ?Today's goals?/^$/-
  ?Today's goals?
endfunction
