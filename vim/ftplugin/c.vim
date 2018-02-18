" Vim filetype plugin
" Language:              C
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" Add system tags
setlocal tags+=~/.sys_c_tags

" Find headers *when we want them*!
setlocal path+=/usr/local/include,/usr/include

" Rebuild tags
nnoremap <buffer> <LocalLeader>tr :!ctags --extra=+f -R *<CR><CR>
