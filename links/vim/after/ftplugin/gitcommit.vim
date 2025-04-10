" Vim filetype plugin
" Language:              Git commit file
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

" Indent two spaces
setlocal shiftwidth=2 softtabstop=2

" Spell check on for commit messages
setlocal spell spelllang=en_us

" Make sure we don't use autoformatting
setlocal formatoptions-=a

setlocal comments+=b:>

nnoremap <buffer> <LocalLeader>d :DiffGitCached<CR>

command -buffer -bar -nargs=? Ref execute 'read !git show --no-patch --format=reference' empty(<q-args>) ? @* : <q-args> | -join
command -buffer -bar Describe read !git config branch.$(git branch --show-current).description

" disable EditorConfig here
let b:EditorConfig_disable = 1

let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ opts: [
      \   'shiftwidth',
      \   'softtabstop',
      \   'spell',
      \   'spelllang',
      \   'formatoptions',
      \   'comments',
      \ ],
      \ maps: [
      \   [ 'n', '<LocalLeader>d' ],
      \ ],
      \ commands: [
      \   'Ref',
      \   'Describe',
      \ ],
      \ vars: [
      \   'b:EditorConfig_disable',
      \ ],
      \ })
