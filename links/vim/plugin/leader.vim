if exists('g:loaded_leader')
  finish
endif
let g:loaded_leader = 1

" Set <Leader> used for mappings
let mapleader = " "
" And <LocalLeader> for buffer mappings
let maplocalleader = '\'

" Clear lines
nnoremap <Leader>cl 0D

" Refactor a word
" Courtesy of github@habamax/.vim/vimrc
nnoremap <Leader>cw :let @/ = expand('<cword>')<CR>cgn

" Save
nnoremap <Leader>s :write<CR>
" Quit quickly
nnoremap <Leader>q :quit<CR>
nnoremap <Leader>Q :qall<CR>
" Suspended (by Matt Nathanson)
nnoremap <Leader>z :suspend<CR>

" Explore
nnoremap <Leader>ed :Explore<CR>
" Quickly input the directory of the current file on the command line
cnoremap <expr> %% filename#command_dir('%%')
" Need 'recursive' mapping here for %%
nmap <Leader>ew :e %%
nmap <Leader>ev :vs %%
nmap <Leader>es :sp %%
nmap <Leader>et :tabe %%
nnoremap <Leader>ef :find **/*
nnoremap <Leader>eb :buffer <C-d>
" Edit alternate file
nnoremap <Leader>` <C-^>
" Quickly edit vimrc
nnoremap <Leader>v :vsplit $MYVIMRC<CR>

" Trigger the command line window
nnoremap <Leader>; q:

" Search very magically
nnoremap <Leader>/ /\v
nnoremap <Leader>? ?\v

" Jump to lines in included files with word
nnoremap <Leader>i :call find#included_word(expand('<cword>'))<CR>
nnoremap <Leader>d :call find#macrod_word(expand('<cword>'))<CR>
" Quickly search tags
nnoremap <Leader>j :tjump /

" Search with global
" Part of me wants to map / and ? to this
nnoremap <Leader>G :global //#<Left><Left>
" Search with grep
nnoremap <leader><leader>g :grep<space>
" Search with vimgrep
nnoremap <leader><leader>v :vimgrep<space>

nnoremap <expr> <Leader>r exists(':Reload') ? ':Reload<CR>' : ''

nnoremap <leader>} dap}p
nnoremap <leader>{ dap{{p

function! s:print_tabs_spaces() abort
  return printf('%s: tabstop=%d softtabstop=%d shiftwidth=%d',
        \ &expandtab ? 'SPACES' : 'TABS',
        \ &tabstop,
        \ &softtabstop,
        \ &shiftwidth)
endfunction

nnoremap <Leader><Leader>t :echomsg <SID>print_tabs_spaces()<CR>

nnoremap <Leader>l :call list#swap()<CR>
xnoremap <Leader>l :call list#swap('visual')<CR>

nnoremap <Leader>cc :call cursor#blink(0.2)<CR>
