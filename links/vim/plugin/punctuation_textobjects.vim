if exists('g:punctuation_textobjects')
  finish
endif
let g:punctuation_textobjects = 1

let s:default_punct = [
      \ '_',
      \ '.',
      \ '/',
      \ '-',
      \ ]

function! s:create_i_map(char) abort
  if ! hasmapto(printf('i%s', a:char), 'vo')
    execute printf('xnoremap <unique> i%s :<C-u>normal! T%svt%s<CR>',
          \ a:char, a:char, a:char)
    execute printf('onoremap <unique> i%s :<C-u>normal vi%s<CR>',
          \ a:char, a:char)
  endif
endfunction

function! s:create_a_map(char) abort
  if ! hasmapto(printf('a%s', a:char), 'vo')
    execute printf('xnoremap <unique> a%s :<C-u>normal! F%svf%s<CR>',
          \ a:char, a:char, a:char)
    execute printf('onoremap <unique> a%s :<C-u>normal va%s<CR>',
          \ a:char, a:char)
  endif
endfunction

for char in get(g:, 'punctuation_chars', s:default_punct)
  call s:create_i_map(char)
  call s:create_a_map(char)
endfor
