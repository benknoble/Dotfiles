" Vim filetype plugin
" Language:              Java
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" Indent two spaces
setlocal shiftwidth=2 softtabstop=2

setlocal foldmethod=syntax

if !empty(findfile('pom.xml', '.;~'))
  let b:interpreter = 'mvn compile com.github.johnpoth:jshell-maven-plugin:1.3:run'
  compiler maven
else
  let b:interpreter = 'jshell'
endif

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'shiftwidth',
      \   'softtabstop',
      \   'foldmethod',
      \   'makeprg',
      \   'errorformat',
      \ ],
      \ 'vars': [
      \   'b:interpreter',
      \ ],
      \ })
