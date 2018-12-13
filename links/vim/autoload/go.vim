function! go#build_go_files() abort
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    :GoTestCompile
  elseif l:file =~# '^\f\+\.go$'
    :GoBuild
  endif
endfunction

