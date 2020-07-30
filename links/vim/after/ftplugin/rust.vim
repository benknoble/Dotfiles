" Vim filetype plugin
" Language:              rust
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if empty(get(b:, 'current_compiler', ''))
  execute 'compiler' (empty(findfile('Cargo.toml', '.;~')) ? 'rustc' : 'cargo')
endif

command -nargs=? -buffer RustDoc
      \ if empty(<q-args>) |
      \   execute "!cargo doc --open" |
      \ else |
      \   execute "!rustup doc" <q-args> " || cargo doc --open" |
      \ endif

setlocal keywordprg=:RustDoc

setlocal includeexpr=rustben#includeexpr(v:fname)
let &l:include='\v^\s*(pub\s+)?use\s+\zs(\f|:)+'
setlocal suffixesadd=.rs

nnoremap <buffer> <localleader>p Ipub<space><esc>
nnoremap <buffer> <localleader>t :call rustben#make_test()<CR>

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'keywordprg',
      \   'include',
      \   'includeexpr',
      \   'suffixesadd',
      \ ],
      \ 'commands': [
      \   'RustDoc',
      \ ],
      \ 'maps': [
      \   [ 'n', '<localleader>p' ],
      \   [ 'n', '<localleader>t' ],
      \ ],
      \ })
