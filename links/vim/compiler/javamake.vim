" Vim compiler file
" Compiler:     javac via make
" Maintainer:   D. Ben Knoble <ben.knoble@gmail.com>

if exists("current_compiler")
  finish
endif
let current_compiler = 'javamake'

if exists(":CompilerSet") != 2          " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=make

" Copied from $VIMRUNTIME/compiler/javac.vim
CompilerSet errorformat=%E%f:%l:\ %m,%-Z%p^,%-C%.%#,%-G%.%#
