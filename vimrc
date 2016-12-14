" only attempt to use pathogen if installed
if !empty(glob("~/.vim/autoload/pathogen.vim"))
	execute pathogen#infect()
endif

set nocompatible
set number
set ruler
set incsearch
set autoindent
set tabstop=4
set nowrap
set showcmd
syntax on
filetype plugin indent on
set whichwrap=b,s,<,>,[,]
set foldcolumn=4
set cindent shiftwidth=4
syntax enable
set t_Co=256
set background=dark
set confirm
set showmatch
set ignorecase
nnoremap <C-E> :Vexplore<CR>
set laststatus=2
let g:airline_theme='dark'
set ttimeoutlen=10
set hidden

" check if dictionary exists
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = '☰'
"let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'
