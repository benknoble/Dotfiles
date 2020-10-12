" Vim filetype plugin
" Language:              dafny
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

call popsikey#register('<Localleader>q', [
      \ #{
      \   key: 'q',
      \   info: 'convert assert quantifier expression to statement',
      \   action: ":call bk#dafny#assert_to_statement()\<CR>",
      \ },
      \ #{
      \   key: 'e',
      \   info: 'convert ensures forall to requires ensures',
      \   action: ":call bk#dafny#ensures_forall_to_requires_ensures()\<CR>",
      \ },
      \ #{
      \   key: 'f',
      \   info: 'toggle forall forms',
      \   action: ":call bk#dafny#switch_forall_type()\<CR>",
      \ },
      \ ], #{})

let b:undo_ftplugin = bk#ftplugin#undo({
      \ 'maps': [
      \   ['n', '<Localleader>q'],
      \   ['n', '<Localleader>qq'],
      \   ['n', '<Localleader>qe'],
      \   ['n', '<Localleader>qf'],
      \ ],
      \ })
