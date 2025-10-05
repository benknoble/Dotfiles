nnoremap <buffer> gf :call wiki#goto(expand('<cfile>'), 'edit')<CR>
nnoremap <buffer> <C-w>f :call wiki#goto(expand('<cfile>'), 'split')<CR>
nnoremap <buffer> <C-w><C-f> :call wiki#goto(expand('<cfile>'), 'vert')<CR>
nnoremap <buffer> <C-w>gf :call wiki#goto(expand('<cfile>'), 'tab')<CR>

const s:mapped_c_h = "\<C-h>" isnot# "\<BS>"
if s:mapped_c_h
  inoremap <buffer> <C-h> <C-r>=wiki#ins_complete_wikis()<CR>
endif

augroup WikiCommit
  " can't use autocmd! here because it would clear the group entirely
  autocmd! * <buffer>
  autocmd BufWritePost <buffer> call bk#wiki#commit()
augroup END

" these are killed when adding the dotted filetype :((
" but they aren't run? So it's not like I lose the maps… weird.
" Really makes me want a better solution to make filetypes more automatically
" composable.
" It looks like $VIMRUNTIME/ftplugin/html.vim is the culprit. I've got
" https://github.com/vim/vim/pull/18267 open to address that.
let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ maps: [
      \   ['n', 'gf'],
      \   ['n', '<C-w>f'],
      \   ['n', '<C-w><C-f>'],
      \   ['n', '<C-w>gf'],
      \ ] + (s:mapped_c_h ? [['i', '<C-h>']] : []),
      \ custom: [
      \   'execute "autocmd! WikiCommit * <buffer>"',
      \ ]
      \ })
