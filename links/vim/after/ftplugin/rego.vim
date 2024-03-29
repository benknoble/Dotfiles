let &l:equalprg = 'opa fmt'

let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ opts: [
      \   'equalprg',
      \ ],
      \ })
