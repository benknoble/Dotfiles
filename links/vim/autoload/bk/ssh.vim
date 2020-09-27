function! bk#ssh#man(word) abort
  " open the man page
  if !exists(':Man')
    runtime! ftplugin/man.vim
  endif
  Man ssh_config
  let @/ = printf('\m^\s*\zs\<%s\>', a:word)
  normal! n
endfunction
