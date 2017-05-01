if &compatible
    set nocompatible
endif

" Options {{{

" Set <Leader> used for mappings
let mapleader="/"

" Allow backspacking over everything in insert mode
set backspace=indent,eol,start

" Keep 200 lines of command history
set history=200

" Show the cursor position all the time
set ruler
" Display incomplete commands
set showcmd
" Display completion matches in the status line
set wildmenu
" Display line numbers
set number

" Time out for key codes
set ttimeout
" Wait up to 100ms after <Esc> for special key
set ttimeoutlen=100

" Show @@@ in the last line if it is truncated
set display=truncate

" Show a few lines of context around the cursor. Note that this makes the text
" scroll if you mouse-click near the start or end of the window
set scrolloff=5

" Do not recognize octal number for Ctrl-A and Ctrl-K
" Also add alpha to formats
set nrformats-=octal
set nrformats+=alpha

" Tab settings: 4 spaces
set tabstop=4
set expandtab
" Used for indent-features ('<<' and the like)
set shiftwidth=4

" Wrap lines that are too long
set wrap
" Allow movements Left and Right to move over wrapped lines
set whichwrap=b,s,<,>,[,]

" Set dark background because I like my terminal dark
set background=dark

" Confirm potentially problematic operations
" Like quitting without writing
set confirm

" Show matching ()[]{} braces
set showmatch

" Ignore case in /? searches
set ignorecase

" Always display status line
set laststatus=2

" Make buffers hidden when unloaded, just in case you want them back
set hidden

" Use {{{,}}} for marking folds
set foldmethod=marker

" Complex options {{{

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
if has('win32')
    set guioptions-=t
endif

" Do incremental searching when it's possible to timeout
if has('reltime')
    set incsearch
endif

if has('mouse')
    set mouse=a
endif

if &term =~ "xterm-256color"
    set t_Co=256
elseif &term =~ "xterm"
    set t_Co=8
endif

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
    " Revert with ":syntax off".
    syntax on

    " I like highlighting strings inside C comments.
    " Revert with ":unlet c_comment_strings".
    let c_comment_strings=1
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    " Revert with ":filetype off".
    filetype plugin indent on

    " Put these in an autocmd group, so that you can revert them with:
    " ":augroup vimStartup | au! | augroup END"
    augroup vimStartup
        au!

        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        autocmd BufReadPost *
            \ if line("'\"") >= 1 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif


    augroup END

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        au!

        " For all text files set 'textwidth' to 78 characters.
        autocmd FileType text setlocal textwidth=78 spell spelllang=en_us
        " But not for help files
        autocmd FileType help setlocal nospell

        " Git commits prefer 72 wrap
        autocmd FileType gitcommit setlocal textwidth=72 spell spelllang=en_us

        " Shell scripts and the like are 80
        autocmd FileType sh setlocal textwidth=80

        " Markdown is 80
        autocmd FileType markdown setlocal textwidth=80 spell spelllang=en_us

        " Automatically add foldcolumn if folds present
        au BufWinEnter ?* call HasFolds()

    augroup END
else
    set autoindent
endif " has("autocmd")

if has('langmap') && exists('+langremap')
    " Prevent that the langmap option applies to characters that result from a
    " mapping.  If set (default), this may break plugins (but it's backward
    " compatible).
    set nolangremap
endif

if has('syntax') && has('eval')
    packadd! matchit
endif

" End complex options }}}

" End options }}}

" Mappings {{{

" Don't use Ex mode, use Q for formatting
" Revert with ":unmap Q"
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

" Center search results
nnoremap n nzz
nnoremap N Nzz
cnoremap <expr> <CR> getcmdtype() =~ '[/?]' ? '<CR>zz' : '<CR>'
" And other motions
nnoremap G Gzz
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz

" Make 'jj' and 'jk' throw you into normal mode
inoremap jj <esc>
inoremap JJ <esc>
inoremap Jj <esc>
inoremap jJ <esc>
inoremap jk <esc>
inoremap JK <esc>
inoremap Jk <esc>
inoremap jK <esc>

" Make buffers like a jetpack: you can fly
nnoremap gb :ls<CR>:b<Space>

" Remap x to delete into the blackhole buffer to make p work better
noremap x "_x

" End Mappings }}}

" Commands, Functions, that jazz {{{

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

" Detects if folds present, sets foldcolumn to 2 if true or 0 if false
" From http://stackoverflow.com/questions/8757168/gvim-automatic-show-foldcolumn-when-there-are-folds-in-a-file
function! HasFolds()
    "Attempt to move between folds, checking line numbers to see if it worked.
    "If it did, there are folds.

    function! HasFoldsInner()
        let origline=line('.')
        :norm zk
        if origline==line('.')
            :norm zj
            if origline==line('.')
                return 0
            else
                return 1
            endif
        else
            return 1
        endif
        return 0
    endfunction

    let l:winview=winsaveview() "save window and cursor position
    let foldsexist=HasFoldsInner()
    if foldsexist
        set foldcolumn=2
    else
        "Move to the end of the current fold and check again in case the
        "cursor was on the sole fold in the file when we checked
        if line('.')!=1
            :norm [z
            :norm k
        else
            :norm ]z
            :norm j
        endif
        let foldsexist=HasFoldsInner()
        if foldsexist
            set foldcolumn=2
        else
            set foldcolumn=0
        endif
    end
    call winrestview(l:winview) "restore window/cursor position
endfunction

" End Commands }}}

" Plugin customization {{{

" Make netrw use a tree
let g:netrw_liststyle=3

" only attempt to use pathogen if installed
if !empty(glob("~/.vim/autoload/pathogen.vim"))
    execute pathogen#infect()
    :Helptags
endif

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

" End plugin customization }}}
