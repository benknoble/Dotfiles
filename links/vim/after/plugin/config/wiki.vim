if !exists('g:wiki_root')
  finish
endif

command -nargs=1 -complete=customlist,wiki#complete_wikis Ewiki execute '<mods> edit' g:wiki_root.'/<args>'
command -nargs=1 -complete=customlist,wiki#complete_wikis Swiki execute '<mods> split' g:wiki_root.'/<args>'
command -nargs=1 -complete=customlist,wiki#complete_wikis Vwiki <mods> vertical Swiki <args>
command -nargs=1 -complete=customlist,wiki#complete_wikis Twiki <mods> tab Swiki <args>


call popsikey#register('<Leader>w', [
      \ #{
      \   key:    'w',
      \   info:   'edit root',
      \   action: ":call wiki#edit_root('split')\<CR>",
      \ },
      \ #{
      \   key:    '/',
      \   info:   'search wiki',
      \   action: ":execute 'grep' input('wiki-grep: ') g:wiki_root\<CR>",
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
