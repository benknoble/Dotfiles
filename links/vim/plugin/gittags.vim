if exists('g:loaded_gittags')
  finish
endif
let g:loaded_gittags = 1

let s:cache = {}

function s:FindGitTags() abort
  const buf = bufnr()
  const job = job_start(['git', 'rev-parse', '--git-path', 'tags'], #{out_cb: funcref('s:Output')})
  let s:cache[job] = #{buf: buf, msg: ''}
endfunction

function s:Output(channel, msg) abort
  const job = ch_getjob(a:channel)
  if !has_key(s:cache, job)
    return
  endif
  " let s:cache[job].msg .= a:msg
  " echom s:cache[job].msg
  const tags = a:msg
  const old_tags = getbufvar(s:cache[job].buf, '&tags', &g:tags)
  const new_tags = empty(old_tags) ? tags : tags .. ',' .. old_tags
  if filereadable(tags)
    call setbufvar(s:cache[job].buf, '&tags', new_tags)
    unlet s:cache[job]
  endif
endfunction

augroup gittags
  autocmd BufRead,BufNewFile * call s:FindGitTags()
augroup end
