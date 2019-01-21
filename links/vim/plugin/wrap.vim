if exists('g:wrap_toggle')
  finish
endif
let g:wrap_toggle = 1

let s:maps = [
      \ 'nnoremap <buffer> j gj',
      \ 'nnoremap <buffer> gj j',
      \ 'nnoremap <buffer> k gk',
      \ 'nnoremap <buffer> gk k',
      \ ]

let s:unmaps = [
      \ 'nunmap <buffer> j',
      \ 'nunmap <buffer> gj',
      \ 'nunmap <buffer> k',
      \ 'nunmap <buffer> gk',
      \ ]


function! s:swap_up_and_down(wrap_is_on) abort
  if a:wrap_is_on
    let l:commands = s:maps
  else
    let l:commands = s:unmaps
  endif

  call execute(l:commands)
endfunction

augroup wrap_toggle
  au!
  autocmd OptionSet wrap call <SID>swap_up_and_down(v:option_new)
augroup END
