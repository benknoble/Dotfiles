if exists('g:loaded_lastpos')
  finish
endif
let g:loaded_lastpos = 1

vim9 var line_number = -1

if has('autocmd')
  augroup vimrc_last_cursor_position
    autocmd!
    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost * {
      line_number = line("'\"")
      if line_number > 1 && line_number <= line('$')
          && &filetype !~# 'commit'
          && index(['xxd', 'gitrebase'], &filetype) < 0
        execute 'normal! g`"'
      endif
    }
  augroup end
endif
