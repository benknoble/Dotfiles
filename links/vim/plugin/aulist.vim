" taken from https://gist.github.com/george-b/2f842efaf2141cb935a81f6174b6401f

let s:has_replied = v:false

function s:feedkeys(str) abort
  call feedkeys(a:str, 'n')
endfunction

function! AutoReply() abort
  let previous_cmdline  = histget('cmd', -1)
  let previous_cmd      = split(previous_cmdline)[0]
  let previous_args     = split(previous_cmdline)[1:]

  let ignorecase    = &ignorecase
  set noignorecase
  let previous_cmd  = get(getcompletion(previous_cmd, 'command'), 0)
  let &ignorecase   = ignorecase

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
