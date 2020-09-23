function s:make_notepad() abort
  nnoremap <buffer> <localleader>d :call <SID>move_tomorrow_to_today()<CR>
  nnoremap <buffer> <localleader>t :call <SID>move_to_tomorrow()<CR>
  nnoremap <buffer> <localleader>w :call <SID>move_to_weekend()<CR>
  xnoremap <buffer> <localleader>t :call <SID>move_to_tomorrow()<CR>
  xnoremap <buffer> <localleader>w :call <SID>move_to_weekend()<CR>
  let b:undo_ftplugin = ftplugin#undo(#{
        \ maps: [
        \   ['n', '<localleader>d'],
        \   ['n', '<localleader>t'],
        \   ['n', '<localleader>w'],
        \   ['x', '<localleader>t'],
        \   ['x', '<localleader>w'],
        \ ],
        \ })
endfunction

function s:move_to_weekend() range abort
  let view = winsaveview()
  execute a:firstline ',' a:lastline 'move /This Weekend//^$/-'
  call winrestview(view)
endfunction

function s:move_to_tomorrow() range abort
  let view = winsaveview()
  execute a:firstline ',' a:lastline 'move /Tomorrow//^$/-'
  call winrestview(view)
endfunction

function s:move_tomorrow_to_today() abort
  /Tomorrow/
  +2,/^$/- move ?Today's goals?/^$/-
  ?Today's goals?
endfunction

augroup Notepad
  autocmd!
  autocmd BufNewFile,BufWinEnter ~/.wiki/notepad call s:make_notepad()
augroup END
