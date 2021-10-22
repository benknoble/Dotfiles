" Vim filetype plugin
" Language:              systemverilog
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" automatically does :runtime! ftplugin/verilog.vim
let b:systemverilog_indent_modules = 1
let b:match_wods = '\<begin\>:\<end\>,\<module\>:\<endmodule\>'

let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ vars: [
      \   'b:systemverilog_indent_modules',
      \   'b:match_wods',
      \ ],
      \ })
