if ! exists(':ALEInfo')
  finish
endif

let g:ale_set_loclist = 0
let g:ale_set_signs = 0
let g:ale_fix_on_save = 0

let g:ale_cursor_detail = 1
let g:ale_floating_preview = 1
let g:ale_floating_window_border = repeat([''], 8)
let g:ale_virtualtext_cursor = 'disabled'

let g:ale_linters = {
      \ 'python': 'all',
      \ 'scala': [],
      \ 'java': [],
      \ 'go': ['gofmt', 'govet', 'golint', 'gopls'],
      \ }

let g:ale_fixers = {
      \ 'python': ['black'],
      \ 'rust': ['rustfmt'],
      \ 'go': ['gofmt'],
      \ }

" lengthen prolog timeout
let g:ale_prolog_swipl_timeout = 10
" no sandboxing
let g:ale_prolog_swipl_load = 'current_prolog_flag(argv, [File]), load_files(File, [sandboxed(false)]), halt.'

let g:ale_python_auto_poetry = v:true

let g:ale_c_cc_options = '-Wall -Wextra -Wmissing-prototypes -Wstrict-prototypes -Wold-style-definition -Wshadow -Wpointer-arith -Wcast-qual -pedantic -std=c11'

let g:ale_rust_cargo_use_clippy = 1

function s:ale_lsp_setup() abort
  setlocal omnifunc=ale#completion#OmniFunc

  nnoremap <buffer> gd :ALEGoToDefinition<CR>
  nnoremap <buffer> gD :ALEFindReferences<CR>
  nnoremap <buffer> g* :ALESymbolSearch <C-r><C-w>

  nnoremap <buffer> <c-k> :ALEPrevious<CR>
  nnoremap <buffer> <localleader><c-k> :ALEFirst<CR>
  nnoremap <buffer> <c-j> :ALENext<CR>
  nnoremap <buffer> <localleader><c-j> :ALELast<CR>

  " Currently not actually visible (?)
  echom 'LSP started'
endfunction

augroup ale_lsp_config
  autocmd!
  autocmd User ALELSPStarted call s:ale_lsp_setup()
augroup END

call popsikey#register('<leader>a', [
      \ #{
      \   key: 'd',
      \   info: 'Documentation',
      \   action: ":ALEDocumentation\<CR>",
      \ },
      \ #{
      \   key: 'f',
      \   info: 'Fix',
      \   action: ":ALEFix\<CR>",
      \ },
      \ #{
      \   key: 'h',
      \   info: 'Hover',
      \   action: ":ALEHover\<CR>",
      \ },
      \ #{
      \    key: 'r',
      \    info: 'Rename',
      \    action: ":ALERename\<CR>",
      \ },
      \ #{
      \    key: 'l',
      \    info: 'Lint',
      \    action: ":ALELint\<CR>",
      \ },
      \ #{
      \    key: 'i',
      \    info: 'Show info',
      \    action: ":ALEInfo\<CR>",
      \ },
      \ #{
      \    key: 'p',
      \    info: 'Populate the location list',
      \    action: ":ALEPopulateLocList\<enter>",
      \ },
      \ ], #{
      \   title: ' ALE ',
      \ })
