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
  let g:dracula_italic = get(g:, 'dracula_italic', 0)
  let g:dracula_colorterm = get(g:, 'dracula_colorterm', 0)
  try
    packadd! dracula
    colorscheme dracula
  catch /^Vim\%((\a\+)\)\=:E\(185\|492\)/
    colorscheme default
    set background=dark
  endtry
endif
" End Dracula }}}
