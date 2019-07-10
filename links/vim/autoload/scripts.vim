function! s:rtp_args(args) abort
  return len(a:args) ? copy(a:args) : [getcwd()]
endfunction

function! scripts#rtp_add_command(...) abort
  let l:dirs = s:rtp_args(a:000)
  let l:opt_value = join(l:dirs, ',')
  " call() because a:000 = [...]
  " scripts#rtp_rm_command(a:000) -> a:000 = [[...]]
  " call(..., a:000) -> a:000 = [...]
  " ONLY BECAUSE scripts#rtp_rm_command uses (...)
  " s:rtp_args uses a:args to avoid this, but we want (...) for <f-args>
  let l:rm_cmd = call('scripts#rtp_rm_command', a:000)
  let l:prepend_cmd = printf('set runtimepath^=%s', l:opt_value)
  return printf('%s | %s', l:rm_cmd, prepend_cmd)
endfunction

" produces separate commands, because set-= chokes when the exact value a,b,d is
" not there; it does *not* remove a and b and c: it removes a,b,c.
function! scripts#rtp_rm_command(...) abort
  let l:dirs = s:rtp_args(a:000)
  let l:rm_cmd = join(
        \ map(l:dirs, {_,d -> printf('set runtimepath-=%s', d)}),
        \ ' | ')
  return l:rm_cmd
endfunction
