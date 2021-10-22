" Vim filetype plugin
" Language:              coq
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

let b:interpreter = 'rlwrap coqtop'

setlocal shiftwidth=2 softtabstop=2
" indent/coq.vim makes this 2, but I don't work with hard-tabs
setlocal tabstop<
" ftplugin/coq.vim adds 'n', which won't work for me
setlocal comments=sr:(*,mb:*,ex:*)

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

let s:maps = []

if exists('*coqtail#register')
  " The function coqtail#define_mappings gets called all the time in
  " unpredictable ways, meaning I can't
  "
  " silent! nunmap <buffer> <localleader>cgg
  " silent! nunmap <buffer> <localleader>cGG
  " silent! nunmap <buffer> g]
  " silent! nunmap <buffer> G]
  " silent! nunmap <buffer> g[
  " silent! nunmap <buffer> G[
  "
  " to get rid of the mappings I want.
  " Instead, let's replicate the logic (twice, actually; see undo_ftplugin) and
  " keep only the maps I want.
  " cf. plugin/config/coqtail.vim where maps are disabled and the prefix is set.
  let s:map_prefix = get(g:, 'coqtail_map_prefix', '<leader>c')

  let s:maps = [
        \   ['Start', 'c', 'n'],
        \   ['Stop', 'q', 'n'],
        \   ['Interrupt', '!<C-c>', 'n'],
        \   ['Next', '!)', 'n'],
        \   ['Undo', '!(', 'n'],
        \   ['ToLine', '!gl', 'n'],
        \   ['ToTop', 'T', 'n'],
        \   ['JumpToEnd', '!g.', 'n'],
        \   ['GotoDef', 'g', 'n'],
        \   ['Search', 's', 'nx'],
        \   ['Check', 'h', 'nx'],
        \   ['About', 'a', 'nx'],
        \   ['Print', 'p', 'nx'],
        \   ['Locate', 'f', 'nx'],
        \   ['RestorePanels', 'r', 'n'],
        \   ['ToggleDebug', 'd', 'n'],
        \ ]

  for [s:cmd, s:key, s:types] in s:maps
    for s:type in split(s:types, '\zs')
      if !hasmapto('<Plug>Coq' . s:cmd, s:type)
        let s:prefix = s:map_prefix
        if s:key[0] ==# '!'
          let s:key = s:key[1:]
          let s:prefix = ''
        endif
        execute s:type . 'map <buffer> ' . s:prefix . s:key . ' <Plug>Coq' . s:cmd
      endif
    endfor
  endfor
endif

let b:undo_ftplugin = bk#ftplugin#undo({
      \ 'opts': [
      \   'shiftwidth',
      \   'softtabstop',
      \   'tabstop',
      \   'comments',
      \ ],
      \ 'vars': [
      \   'b:interpreter',
      \ ],
      \ 'maps': [
      \   [ 'n', '<localleader>a'],
      \   [ 'n', '<localleader>p'],
      \ ] + map(s:maps, { _, v ->
      \       split(v[2], '\zs')
      \       ->map({ _, type -> [type, v[1][0] is# '!' ? v[1][1:] : s:map_prefix . v[1]]})
      \       ->flatten(1)}),
      \ 'abbrevs': [
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
      \ })
