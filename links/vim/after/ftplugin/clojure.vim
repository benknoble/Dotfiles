" Vim filetype plugin
" Language:              clojure
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

let b:interpreter = 'clojure -Arebel'

nmap <buffer> <Localleader>qe ysiebaquote <Esc>:silent! call repeat#set("\<Localleader>qe", -1)<CR>
nmap <buffer> <Localleader>qf ysafbaquote <Esc>:silent! call repeat#set("\<Localleader>qf", -1)<CR>

" commands from fireplace
nnoremap <buffer> <Localleader><Localleader>t :.RunTests<CR>
nnoremap <buffer> <Localleader>t :RunTests<CR>
nnoremap <buffer> <Localleader>T :RunAllTests<CR>

inoreabbrev <buffer> ($ (partial
inoreabbrev <buffer> (o (comp

setlocal lispwords+=are
setlocal lispwords+=cond
setlocal lispwords+=do
setlocal lispwords+=with-out-str
setlocal foldmethod=syntax

augroup CljRequire
  " can't use au! here because it would clear the group entirely
  au! * <buffer>
  au BufWritePost <buffer> silent! Require!<CR>
augroup END

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'lispwords',
      \   'foldmethod',
      \ ],
      \ 'vars': [
      \   'b:interpreter',
      \ ],
      \ 'maps': [
      \   [ 'n', '<Localleader>l' ],
      \   [ 'n', '<Localleader>L' ],
      \   [ 'n', '<Localleader>qe' ],
      \   [ 'n', '<Localleader>qf' ],
      \   [ 'i', '$' ],
      \   [ 'i', 'o' ],
      \ ],
      \ 'custom': [
      \   'au! CljRequire * <buffer>',
      \ ]
      \ })
