" only attempt to use pathogen if installed
if !empty(glob("~/.vim/autoload/pathogen.vim"))
    execute pathogen#infect()
    :Helptags
endif

set nocompatible
set number
set ruler
set incsearch
set autoindent
set tabstop=4
set expandtab
set nowrap
set textwidth=80
" Git commits prefer 72 wrap
autocmd FileType gitcommit set textwidth=72
set showcmd
syntax on
filetype plugin indent on
set whichwrap=b,s,<,>,[,]
set foldcolumn=4
set shiftwidth=4
syntax enable
set t_Co=256
set background=dark
set confirm
set showmatch
set ignorecase
nnoremap <C-E> :Vexplore<CR>
set laststatus=2
set ttimeoutlen=10
set hidden
" center search results
nnoremap n nzz
nnoremap N Nzz
cnoremap <expr> <CR> getcmdtype() =~ '[/?]' ? '<CR>zz' : '<CR>'
let g:netrw_liststyle=3
" Make 'jj' and 'jk' throw you into normal mode
inoremap jj <esc>
inoremap jk <esc>
nnoremap gb :ls<CR>:b<Space>

" set airline-theme if installed
if !empty(glob("~/.vim/bundle/vim-airline-themes"))
    let g:airline_theme='dark'
endif

" customize airline if installed
if !empty(glob("~/.vim/bundle/vim-airline"))
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
endif

" customize syntastic if installed
if !empty(glob("~/.vim/bundle/vim-syntastic"))
    " uncomment below if airline not installed
    " set statusline+=%#warningmsg#
    " set statusline+=%{SyntasticStatuslineFlag()}
    " set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
    let g:syntastic_java_javac_classpath = "."
endif

" customize ctrl-p if installed
if !empty(glob("~/.vim/bundle/vim-ctrlp"))
    let g:ctrlp_show_hidden = 1
    let g:ctrlp_by_filename = 1
    let g:ctrlp_regexp = 1
    let g:ctrlp_switch_buffer = 'E'
    let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'
    let g:ctrlp_working_path_mode = 'ra'
    let g:ctrlp_arg_map = 1
    let g:ctrlp_match_current_file = 1
    let g:ctrlp_lazy_update = 1
    let g:ctrlp_tilde_homedir = 1
endif
