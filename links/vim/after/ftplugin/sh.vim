" Vim filetype plugin
" Language:              [ba]sh script
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" Wrap at 80 characters
setlocal textwidth=80
" Indent two spaces
setlocal shiftwidth=2 softtabstop=2

setlocal keywordprg=:Man

xnoremap <buffer> iv :<C-u>call bk#sh#in_parameter_expansion()<CR>
onoremap <buffer> iv :<C-u>call bk#sh#in_parameter_expansion()<CR>

" technically we're overriding the "in-sentence" motion here, but I can live
" with that
xnoremap <buffer> is :<C-u>call bk#sh#in_subshell()<CR>
onoremap <buffer> is :<C-u>call bk#sh#in_subshell()<CR>

" Relies on surround.vim and custom text object above
nmap <buffer> <LocalLeader>qv ysiv"
nmap <buffer> <LocalLeader>qs ysis"

let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ opts: [
      \   'textwidth',
      \   'shiftwidth',
      \   'softtabstop',
      \   'keywordprg',
      \ ],
      \ maps: [
      \   [ 'x', 'iv' ],
      \   [ 'o', 'iv' ],
      \   [ 'n', '<LocalLeader>qv' ],
      \   [ 'x', 'is' ],
      \   [ 'o', 'is' ],
      \   [ 'n', '<LocalLeader>qs' ],
      \ ],
      \ })
