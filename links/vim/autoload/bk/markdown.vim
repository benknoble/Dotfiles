function! bk#markdown#Folds() abort
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

function! bk#markdown#FoldText() abort
  let foldsize = (v:foldend-v:foldstart)
  return getline(v:foldstart) . ' (' . foldsize . ' lines )'
endfunction

function! s:IsFenced(lnum) abort
  let syntaxgroup = map(synstack(a:lnum,1), 'synIDattr(v:val, "name")')
  return index(syntaxgroup, 'markdownCode') >= 0
endfunction

function! bk#markdown#img_link(text, img, link) abort
  return printf('[![%s](%s)](%s)', a:text, a:img, a:link)
endfunction

"Convert GitHub-Flavored Markdown syntax-highlighting to Liquid
"syntax-highlighting.
function! bk#markdown#to_liquid() range
  let l:range = printf("%s,%s", a:firstline, a:lastline)
  silent! execute l:range.'substitute/^```\([a-z]\+\)$/{% highlight \1 %}/g'
  silent! execute l:range.'substitute/^```$/{% endhighlight %}/g'
endfunction

function! bk#markdown#heading() abort
  let level = getchar()->nr2char()->str2nr()
  return (level is# 0) ? '' : printf("I%s \<esc>", repeat('#', level))
endfunction

function bk#markdown#navigate() abort
  const cursor = getcurpos()
  vimgrep /^#/ %
  call cursor(cursor[1:])
  const line = getline('.')
  const line_nr = line('.')
  if line_nr <= 1
    " use the first error for the first line, whatever it is
    cwindow
  elseif line =~# '^#'
    " for later lines that are errors, find them exactly
    cwindow
    execute printf('/\V|%d \.\*| %s\$', line_nr, line)
    .cc
    wincmd p
  else
    " otherwise use the previous error
    cabove
    cwindow
  endif
endfunction
