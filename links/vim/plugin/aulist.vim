" taken from https://gist.github.com/george-b/2f842efaf2141cb935a81f6174b6401f
" modified in https://gist.github.com/benknoble/d53208c6f1ad8f2130fd706c9cdbd006

if !exists('##CmdlineLeave')
  finish
endif

let s:has_replied = v:false

function s:feedkeys(str) abort
  call feedkeys(a:str, 'n')
endfunction

function! AutoReply() abort
  let previous = split(getcmdline())

  if empty(previous)
    return s:has_replied
  endif

  let previous_cmd = getcompletion(previous[0], 'command')
  if &ignorecase
    " call filter(previous_cmd, { _, v -> !~# previous[0] })
    call filter(previous_cmd, "v:val !~# previous[0]")
  endif
  let previous_cmd  = get(previous_cmd, 0, '')
  let previous_args = previous[1:]

  if empty(previous_cmd)
    return s:has_replied
  endif

  if s:has_replied
    let s:has_replied = v:false
    return s:has_replied
  endif

  let s:has_replied = v:true

  if previous_cmd ==# 'global'
    call s:feedkeys(':')
  elseif previous_cmd ==# 'undolist'
    call s:feedkeys(':undo' . ' ')
  elseif previous_cmd ==# 'oldfiles'
    call s:feedkeys(':edit #<')
  elseif previous_cmd ==# 'marks'
    call s:feedkeys(':normal! `')

  elseif previous_cmd ==# 'changes'
    call s:feedkeys(':normal! g;')
    call s:feedkeys("\<S-Left>")
  elseif previous_cmd ==# 'jumps'
    call s:feedkeys(':normal!' . ' ')
    call s:feedkeys("\<C-O>\<S-Left>")
  elseif previous_cmd ==# 'registers'
    call s:feedkeys(':normal! "p')
    call s:feedkeys("\<Left>")
  elseif previous_cmd ==# 'tags'
    call s:feedkeys(':pop')
    call s:feedkeys("\<Home>")

  elseif index(['ls', 'files', 'buffers'], previous_cmd) != -1
    call s:feedkeys(':buffer' . ' ')
  elseif index(['clist', 'llist'], previous_cmd) != -1
    call s:feedkeys(':' . repeat(previous_cmd[0], 2) . ' ')
  elseif index(['dlist', 'ilist'], previous_cmd) != -1
    call s:feedkeys(':' . previous_cmd[0] . 'jump' . ' ' . join(previous_args))
    call s:feedkeys("\<Home>\<S-Right>\<Space>")

  else
    let s:has_replied = v:false
  endif

  return s:has_replied
endfunction

augroup AutoReply
  autocmd!
  autocmd CmdlineLeave : call AutoReply()
augroup END
