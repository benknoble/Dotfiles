" Vim filetype plugin
" Language:              coq
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

setlocal shiftwidth=2 softtabstop=2
" indent/coq.vim makes this 2, but I don't work with hard-tabs
setlocal tabstop<
" ftplugin/coq.vim adds 'n', which won't work for me
setlocal comments=sr:(*,mb:*,ex:*)

inoreabbrev <buffer> forall ∀
inoreabbrev <buffer> exists ∃
inoreabbrev <buffer> /\ ∧
inoreabbrev <buffer> and ∧
inoreabbrev <buffer> \/ ∨
inoreabbrev <buffer> or ∨
inoreabbrev <buffer> implies →
inoreabbrev <buffer> <-> ↔
inoreabbrev <buffer> iff ↔
inoreabbrev <buffer> ~ ¬
inoreabbrev <buffer> <> ≠
inoreabbrev <buffer> fun λ
inoreabbrev <buffer> le ≤
inoreabbrev <buffer> ge ≥
inoreabbrev <buffer> compose ∘

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
        \   ['Next', 'j', 'n'],
        \   ['Undo', 'k', 'n'],
        \   ['ToLine', 'l', 'n'],
        \   ['ToTop', 'T', 'n'],
        \   ['JumpToEnd', 'G', 'n'],
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
      \ ],
      \ 'maps': [
      \ ] + map(s:maps, { _, v ->
      \     split(v[2], '\zs')
      \       ->map({ _, type -> [ type,
      \                            v[1][1] is# '!' ? v[1][1:] : s:map_prefix . v[1]
      \                          ]})
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
