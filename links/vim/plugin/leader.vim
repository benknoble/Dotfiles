if exists('g:loaded_leader')
  finish
endif
let g:loaded_leader = 1

" Set <Leader> used for mappings
let mapleader=" "
" And <LocalLeader> for buffer mappings
let maplocalleader='\'

" Clear lines
nnoremap <Leader>cl 0D

" Refactor a word
" Courtesy of github@habamax/.vim/vimrc
nnoremap <Leader>cw :let @/=expand('<cword>')<CR>cgn

" Save
nnoremap <silent> <Leader>s :write<CR>
" Quit quickly
nnoremap <silent> <Leader>q :q<CR>
nnoremap <silent> <Leader>Q :qa<CR>
" Suspended (by Matt Nathanson)
nnoremap <silent> <Leader>z :suspend<CR>

" Explore
nnoremap <silent> <Leader>ed :Explore<CR>
" Quickly input the directory of the current file on the command line
cnoremap <expr> %% filename#command_dir('%%')
" Need 'recursive' mapping here for %%
nmap <Leader>ew :e %%
nmap <Leader>ev :vs %%
nmap <Leader>es :sp %%
nmap <Leader>et :tabe %%
nnoremap <Leader>ef :find **/*
" Edit alternate file
nnoremap <Leader>` <C-^>
" Quickly edit vimrc
nnoremap <Leader>v :vsplit $MYVIMRC<CR>

" Trigger the command line window
nnoremap <silent> <Leader>; q:

" Terms and interpreters
" set b:interpreter for filetypes to affect the term
nnoremap <silent> <Leader>t :call terminal#run('++close')<CR>
nnoremap <silent> <Leader>T :call terminal#run()<CR>

" Search very magically
nnoremap <Leader>/ /\v
nnoremap <Leader>? ?\v

" Jump to lines with word
nnoremap <Leader>f :call find#included_word()<CR>
" Unhighlight last search
nnoremap <silent> <Leader>h :nohlsearch<CR>
