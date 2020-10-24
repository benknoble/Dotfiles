setlocal formatprg=rustfmt

let b:undo_indent = bk#ftplugin#undo(#{
      \ opts: [
      \   'formatprg',
      \ ],
      \ }, 'undo_indent')
