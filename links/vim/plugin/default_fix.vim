if exists('g:loaded_default_fix')
  finish
endif
let g:loaded_default_fix = 1

" Yank to end rather than full line
" Like c/C and d/D
nnoremap Y y$

" Stop, for the love of god, 'finding' headers!
set path-=/usr/include

" Do not recognize octal number for Ctrl-A and Ctrl-K
set nrformats-=octal
" And do use "blank" if available
if has('patch-9.1.0537')
  set nrformats+=blank
endif

" Confirm potentially problematic operations
" Like quitting without writing
set confirm

" Add .git/tags to path (since fugitive won't do it anymore)
" Searaches upwards until ~ (because of ;) in case we are in a subdirectory
set tags^=.git/tags;~
