" Inspired by
" https://github.com/LukeSmithxyz/vimling/blob/master/plugin/deadkeys.vim

let s:digraphs = [
      \ { 'letter': 'a', 'accent': '`' },
      \ { 'letter': 'e', 'accent': '`' },
      \ { 'letter': 'i', 'accent': '`' },
      \ { 'letter': 'o', 'accent': '`' },
      \ { 'letter': 'u', 'accent': '`' },
      \ { 'letter': 'A', 'accent': '`' },
      \ { 'letter': 'E', 'accent': '`' },
      \ { 'letter': 'I', 'accent': '`' },
      \ { 'letter': 'O', 'accent': '`' },
      \ { 'letter': 'U', 'accent': '`' },
      \ { 'letter': 'a', 'accent': '^' },
      \ { 'letter': 'e', 'accent': '^' },
      \ { 'letter': 'i', 'accent': '^' },
      \ { 'letter': 'o', 'accent': '^' },
      \ { 'letter': 'u', 'accent': '^' },
      \ { 'letter': 'A', 'accent': '^' },
      \ { 'letter': 'E', 'accent': '^' },
      \ { 'letter': 'I', 'accent': '^' },
      \ { 'letter': 'O', 'accent': '^' },
      \ { 'letter': 'U', 'accent': '^' },
      \ { 'letter': 'a', 'accent': ':' },
      \ { 'letter': 'e', 'accent': ':' },
      \ { 'letter': 'i', 'accent': ':' },
      \ { 'letter': 'o', 'accent': ':' },
      \ { 'letter': 'u', 'accent': ':' },
      \ { 'letter': 'A', 'accent': ':' },
      \ { 'letter': 'E', 'accent': ':' },
      \ { 'letter': 'I', 'accent': ':' },
      \ { 'letter': 'O', 'accent': ':' },
      \ { 'letter': 'U', 'accent': ':' },
      \ { 'letter': 'a', 'accent': "'" },
      \ { 'letter': 'A', 'accent': "'" },
      \ { 'letter': 'C', 'accent': "'" },
      \ { 'letter': 'c', 'accent': "'" },
      \ { 'letter': 'e', 'accent': "'" },
      \ { 'letter': 'E', 'accent': "'" },
      \ { 'letter': 'i', 'accent': "'" },
      \ { 'letter': 'I', 'accent': "'" },
      \ { 'letter': 'N', 'accent': "'" },
      \ { 'letter': 'n', 'accent': "'" },
      \ { 'letter': 'o', 'accent': "'" },
      \ { 'letter': 'R', 'accent': "'" },
      \ { 'letter': 'r', 'accent': "'" },
      \ { 'letter': 'S', 'accent': "'" },
      \ { 'letter': 's', 'accent': "'" },
      \ { 'letter': 'O', 'accent': "'" },
      \ { 'letter': 'u', 'accent': "'" },
      \ { 'letter': 'U', 'accent': "'" },
      \ ]

let s:map_template = 'inoremap <buffer> <silent> %s%s <C-k>%s%s'
let s:unmap_template = 'autocmd InsertLeave <buffer> iunmap <buffer> %s%s'
let s:clear_autocmd_template = 'autocmd InsertLeave <buffer> autocmd! %s'

function! s:make_maps(letter, accent) abort
  let l:cmd_1 = printf(s:map_template, a:letter, a:accent, a:letter, a:accent)
  let l:cmd_2 = printf(s:map_template, a:accent, a:letter, a:letter, a:accent)
  for l:cmd in [l:cmd_1, l:cmd_2]
    execute l:cmd
  endfor
endfunction

function! s:make_unmap_autocmds(letter, accent) abort
  let l:cmd_1 = printf(s:unmap_template, a:letter, a:accent)
  let l:cmd_2 = printf(s:unmap_template, a:accent, a:letter)
  let l:group_name = 'digraphs_unmap_'.a:letter.a:accent
  execute printf('augroup %s', l:group_name)
    autocmd!
    for l:cmd in [l:cmd_1, l:cmd_2]
      execute l:cmd
    endfor
    execute printf(s:clear_autocmd_template, l:group_name)
  augroup END
endfunction

function! digraphs#map(letter, accent) abort
  call s:make_maps(a:letter, a:accent)
  call s:make_unmap_autocmds(a:letter, a:accent)
endfunction

function! digraphs#activate() abort
  for digraph_dict in s:digraphs
    call digraphs#map(digraph_dict.letter, digraph_dict.accent)
  endfor
endfunction
