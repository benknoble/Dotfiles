let &l:equalprg = 'terraform fmt -'

let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ opts: [
      \   'equalprg',
      \ ],
      \ })
