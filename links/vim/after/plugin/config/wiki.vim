if !exists('g:wiki_root')
  finish
endif

command -nargs=1 -complete=customlist,wiki#complete_wikis Ewiki execute 'edit' g:wiki_root.'/<args>'
command -nargs=1 -complete=customlist,wiki#complete_wikis Swiki execute '<mods> split' g:wiki_root.'/<args>'
command -nargs=1 -complete=customlist,wiki#complete_wikis Vwiki vertical Swiki <args>
command -nargs=1 -complete=customlist,wiki#complete_wikis Twiki tab Swiki <args>

const s:wiki_leader = '<leader>w'
const s:wiki_info = [
      \ #{
      \   key:    "w",
      \   info:   "edit root",
      \   action: ":call wiki#edit_root('split')\<CR>",
      \ },
      \ #{
      \   key:    "/",
      \   info:   "search wiki",
      \   action: ":call wiki#search(input('wiki search: '))\<CR>",
      \ },
      \ #{
      \   key:    "e",
      \   info:   "edit wiki",
      \   action: ":Ewiki\<space>",
      \ },
      \ #{
      \   key:    "s",
      \   info:   "split wiki",
      \   action: ":Swiki\<space>",
      \ },
      \ #{
      \   key:    "v",
      \   info:   "vsplit wiki",
      \   action: ":Vwiki\<space>",
      \ },
      \ #{
      \   key:    "t",
      \   info:   "tabedit wiki",
      \   action: ":Twiki\<space>",
      \ },
      \ ]

if has('popupwin')
  const s:wiki_keys = deepcopy(s:wiki_info)->map({_, v -> v.key})
  function WikiHandlePopupKey(id, key) abort
    if a:key is? 'q'
      call popup_close(a:id, -1)
      return v:true
    elseif index(s:wiki_keys, a:key) >= 0
      call popup_close(a:id, a:key)
      return v:true
    endif
    return popup_filter_menu(a:id, a:key)
  endfunction
  function WikiHandlePopupResult(id, result) abort
    if a:result == -1
      return
    endif
    const l:key_index = index(s:wiki_keys, a:result)
    const l:item = l:key_index >= 0 ? l:key_index : (a:result - 1)
    call feedkeys(s:wiki_info[item]['action'], 'n')
  endfunction
  function WikiMakePopup () abort
    const choices =
          \ deepcopy(s:wiki_info)
          \ ->map({i,v -> printf("%s\t%s", v.key, v.info)})
    highlight link PopupSelected Search
    call popup_menu(choices, #{
          \ filter: 'WikiHandlePopupKey',
          \ callback: 'WikiHandlePopupResult',
          \ title: ' wiki-md ',
          \ padding: [1,2,1,2],
          \ pos: 'topleft',
          \ line: 'cursor+1',
          \ col: 'cursor',
          \ })
  endfunction
  execute 'nnoremap' s:wiki_leader ':call WikiMakePopup()<CR>'
else
  for s:item in s:wiki_info
    execute 'nnoremap' s:wiki_leader.s:item['key'] s:item['action']
  endfor
endif
