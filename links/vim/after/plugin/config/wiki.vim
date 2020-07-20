if !exists('g:wiki_root')
  finish
endif

command -nargs=1 -complete=customlist,wiki#complete_wikis Ewiki execute 'edit' g:wiki_root.'/<args>'
command -nargs=1 -complete=customlist,wiki#complete_wikis Swiki execute '<mods> split' g:wiki_root.'/<args>'
command -nargs=1 -complete=customlist,wiki#complete_wikis Vwiki vertical Swiki <args>
command -nargs=1 -complete=customlist,wiki#complete_wikis Twiki tab Swiki <args>


call popsikey#register('<Leader>w', [
      \ #{
      \   key:    'w',
      \   info:   'edit root',
      \   action: ":call wiki#edit_root('split')\<CR>",
      \ },
      \ #{
      \   key:    '/',
      \   info:   'search wiki',
      \   action: ":call wiki#search(input('wiki search: '))\<CR>",
      \ },
      \ #{
      \   key:    'e',
      \   info:   'edit wiki',
      \   action: ":Ewiki\<space>",
      \ },
      \ #{
      \   key:    's',
      \   info:   'split wiki',
      \   action: ":Swiki\<space>",
      \ },
      \ #{
      \   key:    'v',
      \   info:   'vsplit wiki',
      \   action: ":Vwiki\<space>",
      \ },
      \ #{
      \   key:    't',
      \   info:   'tabedit wiki',
      \   action: ":Twiki\<space>",
      \ },
      \ #{
      \   key:    'n',
      \   info:   'edit notepad',
      \   action: ":Ewiki notepad\<CR>",
      \ },
      \ ],
      \ #{
      \   title: ' Wiki ',
      \ })
