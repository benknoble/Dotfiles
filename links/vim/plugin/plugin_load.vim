if exists('g:loaded_plugin_load')
  finish
endif
let g:loaded_plugin_load = 1

" Matchit {{{
if has('packages') && has('syntax') && has('eval')
  packadd matchit
  silent! packadd cfilter
endif
" End Matchit }}}

" Man {{{
" Load Man plugin (see `:help Man` for more info)
runtime ftplugin/man.vim
let g:ft_man_open_mode='vert'
set keywordprg=:Man
" End Man }}}

" Dracula {{{
if ! exists('g:colors_name')
  let s:italic_default = 0
  if $TERM ==# 'xterm-256color'
    if has('osx')
      let &t_ZH = "\e[3m"
      let &t_ZR = "\e[23m"
    elseif has('unix')
      " these xterm profiles are usually correct
    endif
    let s:italic_default = 1
  endif
  let g:dracula_italic = get(g:, 'dracula_italic', s:italic_default)
  let g:dracula_colorterm = get(g:, 'dracula_colorterm', 0)
  try
    colorscheme dracula
  catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
    set background=dark
  endtry
endif
" End Dracula }}}
