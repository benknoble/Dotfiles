function hex#setup() abort
  setlocal binary
  call hex#dump()
  setlocal nomodified

  augroup ftplugin_xxd
    au! * <buffer>

    au BufWritePre <buffer> call hex#write_pre()
    au BufWritePost <buffer> call hex#write_post()
    au TextChanged,InsertLeave <buffer> call hex#update()
  augroup END

  let b:undo_ftplugin = ftplugin#undo({
        \ 'opts': [
        \   'binary',
        \ ],
        \ 'custom': [
        \   'execute "au! ftplugin_xxd * <buffer>"',
        \   'call hex#rev()',
        \ ],
        \ })
endfunction

function hex#dump() abort
  silent %!xxd -g 1
  call hex#strip_trailing_CR()
endfunction

function hex#rev() abort
  silent %!xxd -r
endfunction

function hex#strip_trailing_CR() abort
  %substitute/\r$//e
endfunction

" before writing, translate back to original
function hex#write_pre() abort
  call hex#save_cursor()
  call hex#rev()
endfunction

" after writing, restore hex view and mark unmodified
function hex#write_post() abort
  call hex#dump()
  setlocal nomodified
  call hex#restore_cursor()
endfunction

" update text column after changing hex values
function hex#update() abort
  call hex#save_cursor()
  call hex#rev()
  call hex#dump()
  call hex#restore_cursor()
endfunction

function hex#save_cursor() abort
  let b:xxd_cursor = getpos('.')
endfunction

function hex#restore_cursor() abort
  call setpos('.', b:xxd_cursor)
endfunction
