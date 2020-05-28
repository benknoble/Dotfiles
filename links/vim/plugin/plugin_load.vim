if exists('g:loaded_plugin_load')
  finish
endif
let g:loaded_plugin_load = 1

" Distribution {{{
if has('packages') && has('syntax') && has('eval')
  packadd matchit
  silent! packadd cfilter
endif

" Man {{{
" Load Man plugin (see `:help Man` for more info)
runtime ftplugin/man.vim
let g:ft_man_open_mode = 'split'
let g:ft_man_folding_enable = 1
let g:ft_man_no_sect_fallback = 1
set keywordprg=:Man
" End Man }}}
" End Distribution }}}

" Executables {{{
if executable('tmplr')
  packadd tmplr
endif

if executable('scala')
  packadd scala
endif

if executable('clojure')
  packadd clojure-fireplace
endif

if executable('csharp')
  packadd cs-omnisharp
endif

if executable('docker')
  packadd docker
endif

if executable('go')
  packadd go
endif

if executable('puppet')
  packadd puppet
endif

if executable('tmux')
  packadd tmux
  packadd tmux-tbone
endif

if executable('osascript')
  packadd applescript
endif

if executable('ack')
  packadd ack
endif

if executable('heroku')
  packadd heroku
endif

if executable('vifm')
  packadd vifm
endif
" Executables }}}

" Dracula {{{
if ! exists('g:colors_name')
  let s:italic_default = 0
  if $TERM =~# '\v(xterm|tmux)-256color' || has('gui_running')
    if has('osx')
      let &t_ZH = "\e[3m"
      let &t_ZR = "\e[23m"
    elseif has('unix')
      " these xterm profiles are usually correct
    endif
    let s:italic_default = 1
  elseif $TERM ==# 'alacritty'
    let s:italic_default = 1
  endif
  let g:dracula_italic = get(g:, 'dracula_italic', s:italic_default)
  let g:dracula_colorterm = get(g:, 'dracula_colorterm', 0)
  try
    colorscheme dracula_pro_van_helsing
  catch /^Vim\%((\a\+)\)\=:E185/
    try
      colorscheme dracula
    catch /^Vim\%((\a\+)\)\=:E185/
      colorscheme default
      set background=dark
    endtry
  endtry
endif
" End Dracula }}}
