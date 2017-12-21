" Vim filetype plugin
" Language              Ruby
" Maintainer            Ben Knoble <ben.knoble@gmail.com>

" Wrap at 80 characters
setlocal textwidth=80
" Indent two spaces
setlocal shiftwidth=2 softtabstop=2

" Default to using ruby interactively as the compiler
" Require manual setup of compiler for other projects
compiler ruby

nnoremap <buffer> <LocalLeader>r :make %<CR>
