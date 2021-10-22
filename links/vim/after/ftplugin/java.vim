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

inoremap <buffer> <C-r><C-f> <C-r>=bk#java#class()<CR>

let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ opts: [
      \   'shiftwidth',
      \   'softtabstop',
      \   'foldmethod',
      \   'makeprg',
      \   'errorformat',
      \ ],
      \ maps: [
      \   ['i', '<C-r><C-f>'],
      \ ],
      \ vars: [
      \   'b:interpreter',
      \ ],
      \ })
