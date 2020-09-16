" Vim filetype plugin
" Language:              LaTeX
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

setlocal spell

setlocal iskeyword+=:

nnoremap <buffer> <LocalLeader>4 :s/\$/\\(/ <Bar> s/\$/\\)/<CR>
if exists(':Make')
  nnoremap <buffer> <LocalLeader>o :Make %:r.pdf && open %:r.pdf<CR>
else
  nnoremap <buffer> <LocalLeader>o :make %:r.pdf <Bar> !open %:r.pdf<CR><CR><CR>
endif

command -nargs=1 -buffer Section put =tex#section('<args>')

" $ is so much easier to type than \( and \)
inoremap <buffer> <expr> $ tex#inline()

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'spell',
      \   'iskeyword',
      \ ],
      \ 'maps': [
      \   [ 'n', '<LocalLeader>4' ],
      \   [ 'i', '$' ],
      \ ],
      \ 'commands': [
      \   'Section',
      \ ],
      \ })
