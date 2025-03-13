if exists('g:loaded_plugin_load')
  finish
endif
let g:loaded_plugin_load = 1

" Distribution {{{
if has('packages') && has('syntax') && has('eval')
  packadd matchit
  silent! packadd cfilter
  silent! packadd editorconfig
endif

" Man {{{
" Load Man plugin (see `:help Man` for more info)

" This by itself is VERY slow to load (~100ms):
" runtime ftplugin/man.vim
" So let's hotload it the first time we need it, based on the attributes from
" below (uncomment with "gcc" and run with "<localleader>el" to refresh):
" +,+2delete | put! =execute('runtime ftplugin/man.vim \| command Man') | '[,'] Commentary | -2delete
"     Nom               Args Adresse Complet     Définition
"     Man               +            shellcmd    call dist#man#GetPage(<q-mods>, <f-args>)
command -nargs=+ -complete=shellcmd Man delcommand Man
      \ | if &filetype is# 'man' | setlocal filetype=fixmeman | endif
      \ | runtime ftplugin/man.vim
      \ | if &filetype is# 'fixmeman' | setlocal filetype=man | endif
      \ | <mods> Man <args>

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
