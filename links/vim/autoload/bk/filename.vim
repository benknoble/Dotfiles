" Functions for interacting with filenames

" Get the directory of a file
" - On Ex command lines, returns the directory of the file ('./' for new files)
" - On other command lines (/,?) returns the keymap used to trigger it
function! bk#filename#command_dir(keymap) abort
  let l:command_type = getcmdtype()
  if l:command_type isnot# ':'
    return a:keymap
  endif
  let l:dir = expand('%:h')
  if empty(l:dir)
    let l:dir = '.'
  endif
  return l:dir . '/'
endfunction
