" Vim filetype plugin
" Language              C
" Maintainer            Ben Knoble <ben.knoble@gmail.com>

" Add system tags
setlocal tags+=~/.sys_c_tags

" Rebuild tags
nnoremap <LocalLeader>tr :!ctags --extra=+f -R *<CR><CR>
