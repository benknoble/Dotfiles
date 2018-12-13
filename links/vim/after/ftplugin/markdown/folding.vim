" Vim filetype plugin for folding
" Language:              Markdown
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

setlocal foldtext=markdown#FoldText()

if !exists("*MyMarkdownFoldFtpluginUndo")
  function MyMarkdownFoldFtpluginUndo()
    setlocal foldtext<
  endfunction
endif

let b:undo_ftplugin .= 'call MyMarkdownFoldFtpluginUndo()'
