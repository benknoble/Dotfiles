" Vim filetype plugin
" Language:              zsh
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" Wrap at 80 characters
setlocal textwidth=80
" Indent two spaces
setlocal shiftwidth=2 softtabstop=2

" technically I need a much more complex regex for zsh's parameter expansion,
" but this is good enough for the simpler parts until I get around to it
xnoremap <buffer> iv :<C-u>call bk#sh#in_parameter_expansion()<CR>
onoremap <buffer> iv :<C-u>call bk#sh#in_parameter_expansion()<CR>

" technically we're overriding the "in-sentence" motion here, but I can live
" with that
xnoremap <buffer> is :<C-u>call bk#sh#in_subshell()<CR>
onoremap <buffer> is :<C-u>call bk#sh#in_subshell()<CR>

" Relies on surround.vim and custom text object above
nmap <buffer> <LocalLeader>qv ysiv"
nmap <buffer> <LocalLeader>qs ysis"

setlocal keywordprg=:Man

" temporary fix for b:match_words
let b:match_words = '\<if\>:\<elif\>:\<else\>:\<fi\>'
      \ . ',\<case\>:^\s*([^)]*):\<esac\>'
      \ . ',\<\%(select\|while\|until\|repeat\|for\%(each\)\=\)\>:\<done\>'

let b:ale_sh_shell_default_shell = 'zsh'

let b:undo_ftplugin = bk#ftplugin#undo({
      \ 'opts': [
      \   'textwidth',
      \   'shiftwidth',
      \   'softtabstop',
      \   'iskeyword',
      \   'keywordprg',
      \ ],
      \ 'maps': [
      \   [ 'x', 'iv' ],
      \   [ 'o', 'iv' ],
      \   [ 'n', '<LocalLeader>qv' ],
      \   [ 'x', 'is' ],
      \   [ 'o', 'is' ],
      \   [ 'n', '<LocalLeader>qs' ],
      \ ],
      \ 'vars': [
      \   'b:undo_ftplugin',
      \ ],
      \ })
