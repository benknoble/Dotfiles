" Vim filetype plugin
" Language:              Ruby
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

let b:interpreter = 'irb'
if executable('pry')
  let b:interpreter = 'pry'
endif

" Wrap at 80 characters
setlocal textwidth=80
" Indent two spaces
setlocal shiftwidth=2 softtabstop=2

" Default to using ruby interactively as the compiler
" Require manual setup of compiler for other projects
compiler ruby

nnoremap <buffer> <LocalLeader>r :make %<CR>

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'textwidth',
      \   'shiftwidth',
      \   'softtabstop',
      \   'makeprg',
      \   'errorformat',
      \ ],
      \ 'maps': [
      \   [ 'n', '<LocalLeader>r' ],
      \ ],
      \ 'vars': [
      \   'b:interpreter',
      \ ],
      \ })
