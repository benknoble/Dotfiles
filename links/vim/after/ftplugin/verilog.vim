" Vim filetype plugin
" Language:              verilog
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

setlocal expandtab
setlocal shiftwidth=4 softtabstop=4
let b:verilog_indent_modules = 1

let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ opts: [
      \   'expandtab',
      \   'shiftwidth',
      \   'softtabstop',
      \ ],
      \ vars: [
      \   'b:verilog_indent_modules',
      \ ],
      \ })
