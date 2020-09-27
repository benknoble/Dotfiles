" Vim filetype plugin
" Language:              dafny
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

call popsikey#register('<Localleader>q', [
      \ #{
      \   key: 'q',
      \   info: 'convert assert quantifier expression to statement',
      \   action: ":call bk#dafnyben#assert_to_statement()\<CR>",
      \ },
      \ #{
      \   key: 'f',
      \   info: 'toggle forall forms',
      \   action: ":call bk#dafnyben#switch_forall_type()\<CR>",
      \ },
      \ ], #{})

let b:undo_ftplugin = bk#ftplugin#undo({
      \ 'maps': [
      \   ['n', '<Localleader>q'],
      \ ],
      \ })
