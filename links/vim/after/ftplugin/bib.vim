" Vim filetype plugin
" Language:              bib
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

nnoremap <localleader>d ciw<C-r>=bk#date#month2num('<C-r>"')<CR><Esc>

command -buffer -nargs=1 Cite read !cite <args>

let b:undo_ftplugin = bk#ftplugin#undo({
      \ 'maps': [
      \   [ 'n', '<localleader>d' ],
      \ ],
      \ 'commands': [
      \   'Cite',
      \ ],
      \ })
