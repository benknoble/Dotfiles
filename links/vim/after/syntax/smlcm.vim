" Vim filtype plugin
" Language: SML CM file
" Maintainer: Jake Zimmerman <jake@zimmerman.io>
" Created: 09 Jan 2017
" License: MIT License
"
" This syntax file basically ignores CM preprocessor macros because I've yet
" to see them in real life. If you miss support for CM macros, consider adding
" it!

syn match   smlCommentErr "\*)"

syn keyword smlcmKeyword group   Group   GROUP
syn keyword smlcmKeyword library Library LIBRARY
syn keyword smlcmKeyword source  Source  SOURCE
syn keyword smlcmKeyword is              IS
syn match   smlcmKeyword /\*/
syn match   smlcmKeyword /-/

syn region  smlcmParens start=/(/ end=/)/ contains=ALL

syn region  smlcmComment start=/(\*/ end=/\*)/ contains=smlcmComment,smlcmTodo
syn keyword smlcmTodo contained TODO NOTE FIXME XXX

syn match   smlcmPreproc /^#\s*\<\(if\|else\|elif\|endif\|error\|line\)\>/

"syn match   smlcmPathname /[a-zA-Z0-9`_.;,!%&$+/<=>?@~|#*-^]\+/
syn match   smlcmPathname /\<[a-zA-Z0-9!@#$%^&*_=+|;',<.>/?-]\+\>/
syn match   smlcmLibraryPathname /\$\/\<[a-zA-Z0-9!@#$%^&*_=+|;',<.>/?-]\+\>/
syn region  smlcmNativePathname start=+"+ skip=+\\\\\|\\"+ end=+"+


hi link smlcmKeyword Keyword
hi link smlcmComment Comment
hi link smlcmTodo    Todo

hi link smlcmPreproc PreCondit

hi link smlcmPathname        Constant
hi link smlcmLibraryPathname Identifier
hi link smlcmNativePathname  Constant

let b:current_syntax = "smlcm"
