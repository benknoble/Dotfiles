" Vim filetype plugin for folding
" Language:              Markdown
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

function! MarkdownFolds()
  if s:IsFenced(v:lnum)
    return "="
  endif
  let thisline = getline(v:lnum)
  if match(thisline, '^###') >= 0
      return ">3"
  elseif match(thisline, '^##') >= 0
    return ">2"
  elseif match(thisline, '^#') >= 0
    return ">1"
  else
    return "="
  endif
endfunction

function! s:IsFenced(lnum)
  let syntaxgroup = map(synstack(a:lnum,1), 'synIDattr(v:val, "name")')
  return index(syntaxgroup, 'markdownCode') >= 0
endfunction

function! MarkdownFoldText()
  let foldsize= (v:foldend-v:foldstart)
  return getline(v:foldstart) . ' (' . foldsize . ' lines )'
endfunction

" setlocal foldmethod=expr
" setlocal foldexpr=MarkdownFolds()
setlocal foldtext=MarkdownFoldText()

if !exists("*MyMarkdownFoldFtpluginUndo")
  function MyMarkdownFoldFtpluginUndo()
    setlocal foldtext<
  endfunction
endif

let b:undo_ftplugin .= 'call MyMarkdownFoldFtpluginUndo()'
