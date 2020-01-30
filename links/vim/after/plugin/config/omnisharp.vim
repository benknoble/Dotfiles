if !exists('g:OmniSharp_loaded')
  finish
endif

let g:OmniSharp_server_stdio = 1
let g:OmniSharp_open_quickfix = 0
let g:OmniSharp_server_use_mono = 1

if exists('g:ale_linters')
  let g:ale_linters.cs = extend(
        \ get(
          \ g:ale_linters,
          \ 'cs',
          \ []),
        \ ['OmniSharp'])
endif
