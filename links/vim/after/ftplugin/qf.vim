" Vim filetype plugin
" Language:              Quickfix/Location list windows
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

function! s:getEntryPath(line) abort
  "                          +- match from the first pipe to the end of line
  "                          |  declaring EOL explicitly is faster than implicitly
  "                          |      +- replace match with nothing
  "                          |      |   +- no flags
  return substitute(a:line, '|.*$', '', '')
endfunction

function! s:JumpToFirstItemOfFileChunk() abort
  let l:chunk_file_path = s:getEntryPath(getline('.'))

  while line('.') - 1 != 0
        \ && l:chunk_file_path == s:getEntryPath(getline(line('.') - 1))
    -1
  endwhile

endfunction

function! s:JumpFileChunk(down) abort
  let l:start_file_path = s:getEntryPath(getline('.'))
  let l:direction = a:down ? '+1' : '-1'
  let l:end = a:down ? '$' : 1

  while l:start_file_path == s:getEntryPath(getline('.'))
        \ && getline('.') != getline(l:end)
    execute l:direction
  endwhile

  call s:JumpToFirstItemOfFileChunk()
endfunction

function! s:PreviousFile() abort
  call s:JumpFileChunk(0)
endfunction

function! s:NextFile() abort
  call s:JumpFileChunk(1)
endfunction

nnoremap <buffer> <silent> q :q<CR>

nnoremap <buffer> <silent> <C-n> :call <SID>NextFile()<CR>
nnoremap <buffer> <silent> <C-p> :call <SID>PreviousFile()<CR>

if !exists("*MyQfFtpluginUndo")
  function MyQfFtpluginUndo()
    silent! nunmap <buffer> q
    silent! nunmap <buffer> <C-n>
    silent! nunmap <buffer> <C-p>
  endfunction
endif

let b:undo_ftplugin .= 'call MyQfFtpluginUndo()'
