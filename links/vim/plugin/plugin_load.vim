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

" This by itself is VERY slow to load (~100ms):
" runtime ftplugin/man.vim
" So let's hotload it the first time we need it, based on the attributes from
" below (uncomment with "gcc" and run with "<localleader>el" to refresh):
" +,+2delete | put! =execute('runtime ftplugin/man.vim \| command Man') | '[,'] Commentary | -2delete
"     Nom               Args Adresse Complet     Définition
"     Man               +            shellcmd    call s:GetPage(<q-mods>, <f-args>)
command -nargs=+ -complete=shellcmd Man delcommand Man
      \ | if &filetype is# 'man' | setlocal filetype=fixmeman | endif
      \ | runtime ftplugin/man.vim
      \ | if &filetype is# 'fixmeman' | setlocal filetype=man | endif
      \ | <mods>Man <args>

let g:ft_man_open_mode = 'split'
let g:ft_man_folding_enable = 1
let g:ft_man_no_sect_fallback = 1
set keywordprg=:Man
" End Man }}}
" End Distribution }}}

" Optional Packages {{{
" packadd scala
" packadd clojure-fireplace
" packadd cs-omnisharp
packadd docker
packadd go
" packadd puppet
packadd tmux
packadd tmux-tbone
" packadd applescript
" packadd heroku
packadd rust-doc
" packadd dafny
packadd racket
packadd scribble
packadd coqtail
packadd jqplay
packadd dwarffortress
" Optional Packages }}}

" Colorscheme {{{
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

  " Dracula {{{
  let g:dracula_italic = get(g:, 'dracula_italic', s:italic_default)
  let g:dracula_colorterm = get(g:, 'dracula_colorterm', 0)
  function s:do_dracula() abort
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
  endfunction
  " End Dracula }}}

  " Flattened light {{{
  " consider reworked peachpuff
  function s:do_flattened_light() abort
    try
      colorscheme flattened_light
    catch /^Vim\%((\a\+)\)\=:E185/
      colorscheme default
      set background=light
    endtry
  endfunction
  " End Flattened light }}}

  " COLORSCHEME MARKER
  call s:do_dracula()
endif
" End Colorscheme }}}
