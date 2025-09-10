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

let b:undo_ftplugin = bk#ftplugin#undo(#{
      \ maps: [
      \   ['n', 'gf'],
      \   ['n', '<C-w>f'],
      \   ['n', '<C-w><C-f>'],
      \   ['n', '<C-w>gf'],
      \ ] + (s:mapped_c_h ? [['i', '<C-h>']] : []),
      \ custom: [
      \   'autocmd! WikiCommit * <buffer>',
      \ ]
      \ })
