" Vim filetype plugin
" Language:              Help
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

" Spell check off, by default
setlocal nospell

" Use :help for K in help docs
setlocal keywordprg=:help

nnoremap <silent> <buffer>q :q<CR>

if !exists("*MyHelpFtpluginUndo")
  function MyHelpFtpluginUndo()
    setlocal spell<
    setlocal keywordprg<
    silent! nunmap <buffer> q
  endfunction
endif

let b:undo_ftplugin .= 'call MyHelpFtpluginUndo()'
