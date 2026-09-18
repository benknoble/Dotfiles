function bk#suspense#make() abort
  nnoremap <buffer> <localleader>d A <C-r>=strftime("%Y/%m/%d")<enter><esc>

  let b:undo_ftplugin = bk#ftplugin#undo(#{
        \ maps: [
        \   ['n', '<localleader>d'],
        \ ],
        \ })
endfunction
