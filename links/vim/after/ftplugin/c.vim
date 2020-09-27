" Vim filetype plugin
" Language:              C
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" Find headers *when we want them*!
setlocal path+=/usr/local/include,/usr/include

" Rebuild tags
nnoremap <buffer> <LocalLeader>tr :!ctags --extra=+f -R *<CR><CR>

inoreabbrev <buffer> #i #include
inoreabbrev <buffer> #d #define
inoreabbrev <buffer> main() int main(int argc, char **argv)

let b:undo_ftplugin = bk#ftplugin#undo({
      \ 'opts': [
      \   'path',
      \ ],
      \ 'maps': [
      \   [ 'n', '<LocalLeader>tr' ],
      \ ],
      \ 'abbrevs': [
      \   [ 'i', '#i' ],
      \   [ 'i', '#d' ],
      \   [ 'i', 'main' ],
      \ ],
      \ })
