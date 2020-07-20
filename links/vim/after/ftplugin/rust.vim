" Vim filetype plugin
" Language:              rust
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

command -nargs=? -buffer RustDoc
      \ if empty(<q-args>) |
      \   execute "!cargo doc --open" |
      \ else |
      \   execute "!rustup doc" <q-args> " || cargo doc --open" |
      \ endif

setlocal keywordprg=:RustDoc

nnoremap <buffer> <localleader>p Ipub<space><esc>
nnoremap <buffer> <localleader>t :call <SID>make_test()<CR>

function s:make_test() abort
  if getline('.') !~# '\<fn\>'
    ?\<fn\>
  endif
  normal! O#[test]
endfunction

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'keywordprg',
      \ ],
      \ 'commands': [
      \   'RustDoc',
      \ ],
      \ 'maps': [
      \   [ 'n', '<localleader>p' ],
      \   [ 'n', '<localleader>t' ],
      \ ],
      \ })
