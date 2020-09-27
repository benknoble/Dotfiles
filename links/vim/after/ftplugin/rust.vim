" Vim filetype plugin
" Language:              rust
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if empty(get(b:, 'current_compiler', ''))
  execute 'compiler' (empty(findfile('Cargo.toml', '.;~')) ? 'rustc' : 'cargo')
endif

if !exists(':RustDocFuzzy')
  command -nargs=? -buffer RustDoc
        \ if empty(<q-args>) |
        \   execute "!cargo doc --open" |
        \ else |
        \   execute "!rustup doc" <q-args> " || cargo doc --open" |
        \ endif
endif

if exists(':RustDocFuzzy')
  setlocal keywordprg=:RustDocFuzzy
else
  setlocal keywordprg=:RustDoc
endif

setlocal includeexpr=bk#rust#includeexpr(v:fname)
let &l:include='\v^\s*(pub\s+)?use\s+\zs(\f|:)+'
setlocal suffixesadd=.rs

nnoremap <buffer> <localleader>p Ipub<space><esc>
nnoremap <buffer> <localleader>t :call bk#rust#make_test()<CR>

let b:undo_ftplugin = bk#ftplugin#undo({
      \ 'opts': [
      \   'keywordprg',
      \   'include',
      \   'includeexpr',
      \   'suffixesadd',
      \ ],
      \ 'commands': [
      \ ] + (exists(':RustDocFuzzy') ? [] : ['RustDoc']),
      \ 'maps': [
      \   [ 'n', '<localleader>p' ],
      \   [ 'n', '<localleader>t' ],
      \ ],
      \ })
