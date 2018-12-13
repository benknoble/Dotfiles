function! qf#PreviousFile() abort
  call s:JumpFileChunk(0)
endfunction

function! qf#NextFile() abort
  call s:JumpFileChunk(1)
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

function! s:JumpToFirstItemOfFileChunk() abort
  let l:chunk_file_path = s:getEntryPath(getline('.'))

  while line('.') - 1 != 0
        \ && l:chunk_file_path == s:getEntryPath(getline(line('.') - 1))
    -1
  endwhile

endfunction

function! s:getEntryPath(line) abort
  "                          +- match from the first pipe to the end of line
  "                          |  declaring EOL explicitly is faster than implicitly
  "                          |      +- replace match with nothing
  "                          |      |   +- no flags
  return substitute(a:line, '|.*$', '', '')
endfunction
