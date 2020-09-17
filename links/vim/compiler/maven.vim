" agglomeration of
" https://github.com/JalaiAmitahl/maven-compiler.vim/blob/master/compiler/mvn.vim
" and
" https://github.com/mikelue/vim-maven-plugin/blob/master/compiler/maven.vim

if exists("current_compiler")
  finish
endif

if exists(":CompilerSet") != 2 " older Vim always used :setlocal
  command! -nargs=* CompilerSet setlocal <args>
endif

let current_compiler = "maven"

CompilerSet makeprg=mvn\ --batch-mode

" Error message for POM
CompilerSet errorformat=[FATAL]\ Non-parseable\ POM\ %f:\ %m%\\s%\\+@%.%#line\ %l\\,\ column\ %c%.%#,
CompilerSet errorformat+=[%tRROR]\ Malformed\ POM\ %f:\ %m%\\s%\\+@%.%#line\ %l\\,\ column\ %c%.%#

" Java related build messages
CompilerSet errorformat+=[%tARNING]\ %f:[%l\\,%c]\ %m
CompilerSet errorformat+=[%tRROR]\ %f:[%l\\,%c]\ %m
CompilerSet errorformat+=%A[%t%[A-Z]%#]\ %f:[%l\\,%c]\ %m,%Z
CompilerSet errorformat+=%A%f:[%l\\,%c]\ %m,%Z

" jUnit related build messages
CompilerSet errorformat+=%+E\ \ %#test%m,%Z
CompilerSet errorformat+=%+E[ERROR]\ Please\ refer\ to\ %f\ for\ the\ individual\ test\ results.
" Message from JUnit 5(5.3.X), TestNG(6.14.X), JMockit(1.43), and AssertJ(3.11.X)
CompilerSet errorformat+=%+E%>[ERROR]\ %.%\\+Time\ elapsed:%.%\\+<<<\ FAILURE!,
CompilerSet errorformat+=%+E%>[ERROR]\ %.%\\+Time\ elapsed:%.%\\+<<<\ ERROR!,
CompilerSet errorformat+=%+Z%\\s%#at\ %f(%\\f%\\+:%l),
CompilerSet errorformat+=%+C%.%#

" Misc message removal
CompilerSet errorformat+=%-G[INFO]\ %.%#,
CompilerSet errorformat+=%-G[debug]\ %.%#
