" Vim filetype plugin
" Language:              antlr4
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if !empty(findfile('pom.xml', '.;~'))
  let b:interpreter = 'mvn compile com.github.johnpoth:jshell-maven-plugin:1.3:run'
  compiler maven
endif

let b:undo_ftplugin = bk#ftplugin#undo({
      \ 'opts': [
      \   'makeprg',
      \   'errorformat',
      \ ],
      \ })
