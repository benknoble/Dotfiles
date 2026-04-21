" Vim filetype plugin
" Language:              coq
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

let b:interpreter = 'rlwrap rocq repl'

setlocal shiftwidth=2 softtabstop=2
" indent/coq.vim makes this 2, but I don't work with hard-tabs
setlocal tabstop<
" ftplugin/coq.vim adds 'n', which won't work for me
setlocal comments=sr:(*,mb:*,ex:*)

Conceal

inoreabbrev <buffer> <expr> forall bk#abbr#not_comment('forall', '∀')
inoreabbrev <buffer> <expr> exists bk#abbr#not_comment('exists', '∃')
inoreabbrev <buffer> <expr> /\ bk#abbr#not_comment('/\', '∧')
inoreabbrev <buffer> <expr> and bk#abbr#not_comment('and', '∧')
inoreabbrev <buffer> <expr> \/ bk#abbr#not_comment('\/', '∨')
inoreabbrev <buffer> <expr> or bk#abbr#not_comment('or', '∨')
inoreabbrev <buffer> <expr> implies bk#abbr#not_comment('implies', '→')
inoreabbrev <buffer> <expr> <-> bk#abbr#not_comment('<->', '↔')
inoreabbrev <buffer> <expr> iff bk#abbr#not_comment('iff', '↔')
inoreabbrev <buffer> <expr> ~ bk#abbr#not_comment('~', '¬')
inoreabbrev <buffer> <expr> <> bk#abbr#not_comment('<>', '≠')
inoreabbrev <buffer> <expr> fun bk#abbr#not_comment('fun', 'λ')
inoreabbrev <buffer> <expr> le bk#abbr#not_comment('le', '≤')
inoreabbrev <buffer> <expr> ge bk#abbr#not_comment('ge', '≥')
inoreabbrev <buffer> <expr> compose bk#abbr#not_comment('compose', '∘')

nnoremap <buffer> <localleader>a :call bk#coq#get_def(expand('<cword>'), 'About')<CR>
nnoremap <buffer> <localleader>p :call bk#coq#get_def(expand('<cword>'), 'Print')<CR>

" see plugin/config/coqtail.vim
let s:maps = ['(', ')', 'gl', 'g.' ]

let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ opts: [
      \   'shiftwidth',
      \   'softtabstop',
      \   'tabstop',
      \   'comments',
      \ ],
      \ vars: [
      \   'b:interpreter',
      \ ],
      \ maps: [
      \   [ 'n', '<localleader>a'],
      \   [ 'n', '<localleader>p'],
      \ ] + map(s:maps, { _, v -> [ 'n', v ] }),
      \ abbrevs: [
      \   [ 'i', 'forall' ],
      \   [ 'i', 'exists' ],
      "\ some doubling necessary; the slashes will be injected to double-quotes
      \   [ 'i', '/\\' ],
      \   [ 'i', 'and' ],
      \   [ 'i', '\\/' ],
      \   [ 'i', 'or' ],
      \   [ 'i', 'implies' ],
      \   [ 'i', '<->' ],
      \   [ 'i', 'iff' ],
      \   [ 'i', '~' ],
      \   [ 'i', '<>' ],
      \   [ 'i', 'fun' ],
      \   [ 'i', 'le' ],
      \   [ 'i', 'ge' ],
      \   [ 'i', 'compose' ],
      \ ],
      \ custom: [
      \   'Reveal',
      \ ],
      \ })
