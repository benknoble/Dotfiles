if exists('g:loaded_lastpos')
  finish
endif
let g:loaded_lastpos = 1

if has('autocmd')
  augroup vimrc_last_cursor_position
    autocmd!
    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'gitcommit' |
          \   exe "normal! g`\"" |
          \ endif
  augroup END
endif
