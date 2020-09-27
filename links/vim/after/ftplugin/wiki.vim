nnoremap <buffer> gf :call bk#wiki#goto(expand('<cfile>'), 'edit')<CR>
nnoremap <buffer> <C-w>f :call bk#wiki#goto(expand('<cfile>'), 'split')<CR>
nnoremap <buffer> <C-w><C-f> :call bk#wiki#goto(expand('<cfile>'), 'vert')<CR>
nnoremap <buffer> <C-w>gf :call bk#wiki#goto(expand('<cfile>'), 'tab')<CR>

let b:undo_ftplugin = bk#ftplugin#undo({
      \ 'maps': [
      \   ['n', 'gf'],
      \   ['n', '<C-w>f'],
      \   ['n', '<C-w><C-f>'],
      \   ['n', '<C-w>gf'],
      \ ],
      \ })
