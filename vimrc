if &compatible
  set nocompatible
endif

" Options {{{

" Leader {{{
" Set <Leader> used for mappings
let mapleader=" "
" And <LocalLeader> for buffer mappings
let maplocalleader="\\"
" End Leader }}}

" Allow backspacking over everything in insert mode
set backspace=indent,eol,start

" Keep 200 lines of command history
set history=200

" Update faster
set updatetime=250

" Viminfo {{{
" Keep marks
set viminfo+=f1
if exists("&viminfofile")
  set viminfofile=$HOME/.viminfo
endif
" End Viminfo }}}

" Status display {{{
" Show the cursor position all the time
set ruler
" And highlight the line it's on
set cursorline
" Display incomplete commands
set showcmd
" Always display status line
set laststatus=2
" End status display }}}

" Command-line quickly {{{
" Display completion matches in the status line
set wildmenu
" Search in subdirs for finding files
set path+=**
" End Command-line quickly }}}

" Timeout {{{
" Time out for key codes
set ttimeout
" Wait up to 100ms after <Esc> for special key
set ttimeoutlen=100
" But 3000ms (3s) for mappings
set timeoutlen=3000
" End Timeout }}}

" Window Display {{{
if has("patch-7.4.2109")
  " Show @@@ in the last line if it is truncated
  set display=truncate
else
  set display=lastline
endif
" Show a few lines of context around the cursor. Note that this makes the text
" scroll if you mouse-click near the start or end of the window
set scrolloff=5
" End Window Display }}}

" Don't equalize window sizes automatically
set noequalalways

" Do not recognize octal number for Ctrl-A and Ctrl-K
" Also add alpha to formats
set nrformats-=octal
set nrformats+=alpha

" Tabs {{{
" Tab settings: 4 spaces (unless overriden by ftplugin)
" A Tab character has length 8
set tabstop=8
" Use spaces when pressing Tab in insert
set expandtab
" Used for indent-features ('<<' and the like)
set shiftwidth=4
" Round < and the like to nearest shiftwidth
set shiftround
" Backspace over 4 spaces if possible
set softtabstop=4
" End Tabs }}}

" Wrap {{{
set textwidth=80
" Wrap lines that are too long
set wrap
" Show wrapped lines with a marker in front
let &showbreak='» '
" Break at word boundaries
set linebreak
" Allow movements Left and Right to move over wrapped lines
set whichwrap=b,s,<,>,[,]
" End Wrap }}}

" Display certain whitespace characters
set list listchars=tab:»\ ,trail:·,nbsp:⎵

" Set dark background because I like my terminal dark
set background=dark

" Confirm potentially problematic operations
" Like quitting without writing
set confirm

" Show matching ()[]{} braces
set showmatch

" Search {{{
" Ignore case in /? searches
set ignorecase
" Unless capitals are present
set smartcase
" Highlight searches
set hlsearch
" End Search }}}

" Complete from dictionary if spell on
set complete+=kspell

" Make buffers hidden when unloaded, just in case you want them back
set hidden

" Use {{{,}}} for marking folds
set foldmethod=marker

" Complex options {{{

" Win32 Gui {{{
" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
if has('win32')
  set guioptions-=t
endif
" End Win32 GUI }}}

" Incremental Search {{{
" Do incremental searching when it's possible to timeout
if has('reltime')
  set incsearch
endif
" End Incremental Search }}}

" +mouse {{{
if has('mouse')
  set mouse=a
endif
" End +mouse }}}

" Window title {{{
" DONT set window title if possible (for Terminal applications)--plays weird
if has('title')
  set notitle
endif
" End Window title }}}

" 't_Co' {{{
if &term =~ "xterm-256color"
  set t_Co=256
elseif &term =~ "xterm"
  set t_Co=8
endif
" End 't_Co' }}}

" Syntax Highlighting {{{
" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
  " Revert with ":syntax off".
  syntax on

  " I like highlighting strings inside C comments.
  " Revert with ":unlet c_comment_strings".
  let c_comment_strings=1
endif
" End Syntax Highlighting }}}

" Undo {{{
set undofile undodir=~/.undo

if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif
" End Undo }}}

" Autocmd {{{
" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " Revert with ":filetype off".
  filetype plugin indent on

  " vimrc_last_cursor_position {{{
  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup vimrc_last_cursor_position | au! | augroup END"
  augroup vimrc_last_cursor_position
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
          \ if line("'\"") >= 1 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif

  augroup END
  " End vimrc_last_cursor_position }}}

  " vimrc_autofoldcolumn {{{
  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup autofoldcolumn | au! | augroup END"
  augroup vimrc_autofoldcolumn
    au!

    " Automatically add foldcolumn if folds present
    " Needs Auto Origami plugin
    au CursorHold,BufWinEnter,WinEnter * let &foldcolumn =
          \ auto_origami#Foldcolumn()

  augroup END
  " End vimrc_autofoldcolumn }}}

  " vimrc_formatoptions {{{
  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup formatoptions | au! | augroup END"
  augroup vimrc_formatoptions
    au!

    au FileType * setlocal formatoptions-=cro

  augroup END
  " End vimrc_formatoptions }}}

  " vimrc_completion {{{
  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup completion | au! | augroup END"
  augroup vimrc_completion
    au!

    " Add omnicompletion using syntax if a file doesn't already have it
    au FileType * if &omnifunc == "" |
          \ setlocal omnifunc=syntaxcomplete#Complete |
          \ endif

  augroup END
  " End vimrc_completion }}}

  " vimrc_toggle_cursorline {{{
  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup vimrc_toggle_cursorline | au! | augroup END"
  augroup vimrc_toggle_cursorline
    au!

    " Don't use cursorline in Insert mode
    au InsertEnter * setlocal nocursorline
    au InsertLeave * setlocal cursorline

  augroup END
  " End vimrc_toggle_cursorline }}}

  " vimrc_plugins {{{
  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup vimrc_plugins | au! | augroup END"
  augroup vimrc_plugins
    au!

    autocmd User AirlineAfterInit call AirlineInit()

  augroup END
  "End vimrc_plugins }}}

  " vimrc_gitcommit {{{
  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup vimrc_gitcommit | au! | augroup END"
  augroup vimrc_gitcommit
    au!

    autocmd FileType gitcommit :normal! gg

  augroup END
  "End vimrc_gitcommit }}}

else
  set autoindent
endif " has("autocmd")
" End autocmd }}}

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

" Formatting {{{
" Don't use Ex mode, use Q for formatting
" Revert with ":unmap Q"
nnoremap Q gq
" Format the whole line
nnoremap QQ gqgq
" End Formatting }}}

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

" Search {{{
" Search very magically
" Seriously who doesn't want this
nnoremap / /\v
nnoremap ? ?\v
" End Search }}}

" Center {{{
" Center search results
nnoremap n nzz
nnoremap N Nzz
cnoremap <expr> <CR> getcmdtype() =~ '[/?]' ? '<CR>zz' : '<CR>'
" And other motions
nnoremap G Gzz
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
" Center cursor on click
" nnoremap <LeftMouse> <LeftMouse>zz
" End Center }}}

" Alt escape {{{
" Make 'jj' and 'jk' throw you into normal mode
inoremap jj <esc>
inoremap JJ <esc>
inoremap Jj <esc>
inoremap jJ <esc>
inoremap jk <esc>
inoremap JK <esc>
inoremap Jk <esc>
inoremap jK <esc>
" End alt escape }}}

" Buffers {{{
" Make buffers like a jetpack: you can fly
nnoremap gb :ls<CR>:b<Space>
nnoremap <Leader>b :ls<CR>:b<Space>
" End Buffers }}}

" gi goes to end of last insert (`^)
" gI goes to last change
nnoremap gI `.

" Remap x to delete into the blackhole buffer to make p work better
noremap x "_x

" Line numbers {{{
" Toggle linenumbers
nnoremap <silent> <Leader>n :setlocal number!<CR>
nnoremap <silent> <Leader>N :setlocal relativenumber!<CR>
" End Line numbers }}}

" Unhighlight last search
nnoremap <silent> <Leader>h :nohlsearch<CR>

" Reload {{{
" Reload with F5
nnoremap <F5> :Reload<CR>
" Or <Leader>[rR]
nnoremap <Leader>r :Reload<CR>
nnoremap <Leader>R :ReloadAir<CR>
" End Reload }}}

" Quit with Q too, so you can hold shift
" Note that it displays ':q' even if you type ':Q'
cnoremap Q q

" "Uppercase word" mapping {{{
"
" This mapping allows you toress <c-u> in insert mode to convert the current
" word to uppercase.  It's handy when you're writing names of constants and
" don't want to use Capslock.
"
" To use it you type the name of the constant in lowercase.  While your
" cursor is at the end of the word,ress <c-u> to uppercase it, and then
" continue happily on your way:
"
"                            cursor
"                            v
"     max_connections_allowed|
"     <c-u>
"     MAX_CONNECTIONS_ALLOWED|
"                            ^
"                            cursor
"
" It works by exiting out of insert mode, recording the current cursor location
" in the z mark, using gUiw to uppercase inside the current word, moving back to
" the z mark, and entering insert mode again.
"
" Note that this will overwrite the contents of the z mark.  I never use it, but
" if you do you'll probably want to use another mark.
inoremap <C-u> <esc>mzgUiw`za
" End uppercase word mapping }}}

" Not technically a mapping, but acts like one
" Toggle paste mode during an insert with <F7>
set pastetoggle=<F7>
" Panic button
nnoremap <F9> mzggg?G`z

" Leader shortcuts {{{
" Edit alternate file
nnoremap <Leader>` <C-^>
" Save
nnoremap <Leader>s :write<CR>
" Clear lines
nnoremap <Leader>cl ddO<ESC>

" Quickly edit vimrc
nnoremap <Leader>ev :vsplit $MYVIMRC<CR>

" Surround word with "
nnoremap <Leader>" viw<esc>a"<esc>bi"<esc>lel
" Surround word with '
nnoremap <Leader>' viw<esc>a'<esc>bi'<esc>lel

" Surround visual selection with "
vnoremap <Leader>" <esc>`<i"<esc>`>a"<esc>
" Surround visual selection with '
vnoremap <Leader>' <esc>`<i'<esc>`>a'<esc>

" Quit quickly
nnoremap <silent> <Leader>q :q<CR>
" End Leader shortcuts }}}

" Window mappings {{{

" Don't even let me use <C-w>
nnoremap <C-w>     <nop>
" Because I can use <Leader>w for everything
nnoremap <Leader>w <C-w>

" End Window mappings }}}

" Lines {{{
" Move lines up and down
nnoremap - ddp
nnoremap _ ddkP
" Insert blank lines with <CR>
nnoremap <CR> o<esc>
" Yank to end rather than full line
" Like c/C and d/D
nnoremap Y y$
" End Lines }}}

" Operator motions {{{
" Operator motion for In Next ( in line
onoremap <silent> in( :<C-u>normal! f(vi(<CR>
" Operator motion for In Last ( in line
onoremap <silent> il( :<C-u>normal! F)vi(<CR>
" Operator motion for Around Next ( in line
onoremap <silent> an( :<C-u>normal! f(va(<CR>
" Operator motion for Around Last ( in line
onoremap <silent> al( :<C-u>normal! F)va(<CR>
" Operator motion for In Next { in line
onoremap <silent> in{ :<C-u>normal! f{vi{<CR>
" Operator motion for In Last { in line
onoremap <silent> il{ :<C-u>normal! F}vi{<CR>
" Operator motion for Around Next { in line
onoremap <silent> an{ :<C-u>normal! f{va{<CR>
" Operator motion for Around Last { in line
onoremap <silent> al{ :<C-u>normal! F}va{<CR>
" End Operator motions }}}

" Quickfix {{{
" Quickly navigate quickfix
nnoremap <silent> <Leader>cn :cnext<CR>
nnoremap <silent> <Leader>cp :cprev<CR>
" End Quickfix }}}

" End Mappings }}}

" Commands, Functions, that jazz {{{

" Diff {{{
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
" Undo with ":set nodiff foldmethod=marker"
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif
" End Diff }}}

" Reload {{{
" Reload vimrc
" If airline gets weird, try ":ReloadAir"
if !exists(":Reload")
  command -bar Reload source $MYVIMRC
endif

" Reload vimrc and refresh airline
if !exists(":ReloadAir")
  command -bar ReloadAir :Reload | AirlineRefresh
endif
" End Reload }}}

" AirlineInit {{{
" Customize airline (call in autocmd AirlineAfterInit)
function! AirlineInit()
  let g:airline_section_c=airline#section#create(['path', ' ', 'readonly'])
endfunction
" End AirlineInit }}}

" End Commands }}}

" Plugin customization {{{

" Man {{{
" Load Man plugin (see `:help Man` for more info)
runtime ftplugin/man.vim
let g:ft_man_open_mode='vert'
set keywordprg=:Man
" End Man }}}

" Netrw {{{
" Make netrw use a long listing
let g:netrw_liststyle=1
" Don't display baner
let g:netrw_banner=0
" Sort by size
let g:netrw_sort_by="size"
" Hide things not tracked by gitignore
" let g:netrw_list_hide=netrw_gitignore#Hide()
" Something is going screwy here^
" End netrw }}}

" Pathogen {{{
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
:Helptags
" End Pathogen }}}

" Airline theme {{{
" set airline-theme if installed
if !empty(glob("~/.vim/bundle/vim-airline-themes"))
  let g:airline_theme='dark'
endif
" End Airline theme }}}

" Airline {{{
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

  " Enable tabline
  let g:airline#extensions#tabline#enabled = 1
  " Show splits
  let g:airline#extensions#tabline#show_splits = 1
  " Show buffers with one tab
  let g:airline#extensions#tabline#show_buffers = 1
  " Don't show preview window buffer
  let g:airline#extensions#tabline#exclude_preview = 1
  " Show splits and tab number
  let g:airline#extensions#tabline#tab_nr_type = 2
  " Show tab type (far right)
  let g:airline#extensions#tabline#show_tab_type = 1
  " Use default formatter
  let g:airline#extensions#tabline#formatter = 'default'
  " Don't show buffer numbers
  let g:airline#extensions#tabline#buffer_nr_show = 0
  " Configure separators for the tabline only
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline#extensions#tabline#right_sep = ' '
  let g:airline#extensions#tabline#right_alt_sep = '|'
  " Don't show close button
  let g:airline#extensions#tabline#show_close_button = 0
  " Buffer number formatting
  " let g:airline#extensions#tabline#buffer_nr_format = 'b#%s '
  " Filename formatting
  let g:airline#extensions#tabline#fnamemod = ':~:.'
  " Fixes unneccessary redraw, when e.g. opening Gundo window
  let airline#extensions#tabline#ignore_bufadd_pat =
        \ '\c\vgundo|undotree|vimfiler|tagbar|nerd_tree'
  " Enable buffer index number
  let g:airline#extensions#tabline#buffer_idx_mode = 1
  nmap <leader>1 <Plug>AirlineSelectTab1
  nmap <leader>2 <Plug>AirlineSelectTab2
  nmap <leader>3 <Plug>AirlineSelectTab3
  nmap <leader>4 <Plug>AirlineSelectTab4
  nmap <leader>5 <Plug>AirlineSelectTab5
  nmap <leader>6 <Plug>AirlineSelectTab6
  nmap <leader>7 <Plug>AirlineSelectTab7
  nmap <leader>8 <Plug>AirlineSelectTab8
  nmap <leader>9 <Plug>AirlineSelectTab9
  nmap <leader>- <Plug>AirlineSelectPrevTab
  nmap <leader>+ <Plug>AirlineSelectNextTab
  " Change the display format of the buffer index
  let g:airline#extensions#tabline#buffer_idx_format = {
        \ '0': '#0 ',
        \ '1': '#1 ',
        \ '2': '#2 ',
        \ '3': '#3 ',
        \ '4': '#4 ',
        \ '5': '#5 ',
        \ '6': '#6 ',
        \ '7': '#7 ',
        \ '8': '#8 ',
        \ '9': '#9 '
        \}

  " Enable windowswap
  let g:airline#extensions#windowswap#enabled = 1
  let g:airline#extensions#windowswap#indicator_text = 'WS'
endif
" End Airline }}}

" Syntastic {{{
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
" End Syntastic }}}

" Windowswap {{{
" Customize windowswap if installed
if !empty(glob("~/.vim/bundle/vim-windowswap"))
  " Don't use windowswap keys
  let g:windowswap_map_keys=0
  " Use this instead
  nnoremap <Leader>wm :call WindowSwap#EasyWindowSwap()<CR>
endif
" End Windowswap }}}

" Undotree {{{
" Customize undotree
if !empty(glob("~/.vim/bundle/vim-undotree"))
  nnoremap <silent> <Leader>u :UndotreeToggle<CR>
  let g:undotree_SetFocusWhenToggle=1
endif
" End Undotree }}}

" End plugin customization }}}

" Abbreviations {{{

iabbrev lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit
iabbrev llorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi
iabbrev lllorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi.  Integer hendrerit lacus sagittis erat fermentum tincidunt.  Cras vel dui neque.  In sagittis commodo luctus.  Mauris non metus dolor, ut suscipit dui.  Aliquam mauris lacus, laoreet et consequat quis, bibendum id ipsum.  Donec gravida, diam id imperdiet cursus, nunc nisl bibendum sapien, eget tempor neque elit in tortor

iabbrev eemail ben.knoble@gmail.com
iabbrev wweb benknoble.github.io
iabbrev ssig --<CR>David Ben Knoble<CR>ben.knoble@gmail.com
iabbrev ccopy © Copyright David Ben Knoble 2017, all rights reserved.

" Eng abbreviations }}}
