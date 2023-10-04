if ! exists(':ALEInfo')
  finish
endif

let g:ale_set_signs = 0
let g:ale_lint_on_enter = 0
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

" keep python files limited in line length (88 is too much)
" see ~/.vim/after/ftplugin/python.vim
let g:ale_python_black_options = '--line-length 79'

function s:ale_lsp_setup() abort
  setlocal omnifunc=ale#completion#OmniFunc

  nnoremap <buffer> gd :ALEGoToDefinition<CR>
  nnoremap <buffer> gD :ALEFindReferences<CR>
  nnoremap <buffer> g* :ALESymbolSearch <C-r><C-w>

  nnoremap <buffer> [l :ALEPrevious<CR>
  nnoremap <buffer> [L :ALEFirst<CR>
  nnoremap <buffer> ]l :ALENext<CR>
  nnoremap <buffer> ]L :ALELast<CR>

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
      \ ], #{
      \   title: ' ALE ',
      \ })
