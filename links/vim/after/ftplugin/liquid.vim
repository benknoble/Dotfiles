" Vim filetype plugin
" Language:              Markdown
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:liquid_subtype')
  if ! exists('b:ale_linter_aliases')
    let b:ale_linter_aliases = []
  endif
  let b:ale_linter_aliases += [ b:liquid_subtype ]

  function! MyLiquidFtpluginUndo()
    let l:i = index(b:ale_linter_aliases, b:liquid_subtype)
    if l:i >= 0
      call remove(b:ale_linter_aliases, l:i)
    endif
  endfunction

  let b:undo_ftplugin = ftplugin#undo({
        \ 'custom': [
        \   'call MyLiquidFtpluginUndo',
        \ ],
        \ })
endif
