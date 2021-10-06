" Vim filetype plugin
" Language:              Go
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

nnoremap <buffer> <localleader>t :compiler gotest <bar> make <bar> compiler go<CR>
nnoremap <buffer> <localleader>c :GoCoverage toggle<CR>

" Indent settings
setlocal tabstop=4
setlocal shiftwidth=0
setlocal softtabstop=0

function s:GoDoc(kw) abort
  let keyword = a:kw
  let doc = systemlist('go doc '..shellescape(keyword))
  if v:shell_error isnot# 0
    let keyword = getline('.')->matchstr('\k\+\.\V'..escape(keyword, '\')) ?? keyword
    let doc = systemlist('go doc '..shellescape(keyword))
  endif
  if v:shell_error isnot# 0
    redraw " force redraw so echo is visible, even in visual mode
    echo 'No help for "'..keyword..'"'
  else
    echo join(doc, "\n")
  endif
endfunction

command -nargs=1 -buffer GoDoc call s:GoDoc(<f-args>)

setlocal keywordprg=:GoDoc

let b:undo_ftplugin = bk#ftplugin#undo({
      \ 'opts': [
      \   'tabstop',
      \   'shiftwidth',
      \   'softtabstop',
      \   'keywordprg',
      \ ],
      \ 'maps': [
      \   [ 'n', '<LocalLeader>t' ],
      \   [ 'n', '<LocalLeader>c' ],
      \ ],
      \ 'commands': [
      \   'GoDoc',
      \ ],
      \ })
