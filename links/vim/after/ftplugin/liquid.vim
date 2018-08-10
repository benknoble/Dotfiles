" Vim filetype plugin
" Language:              Markdown
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif

if exists('b:liquid_subtype')
  if ! exists('b:ale_linter_aliases')
    let b:ale_linter_aliases = []
  endif
  let b:ale_linter_aliases += [ b:liquid_subtype ]

  if !exists("*MyLiquidFtpluginUndo")
    function MyLiquidFtpluginUndo()
      let l:i = index(b:ale_linter_aliases, b:liquid_subtype)
      if l:i >= 0
        call remove(b:ale_linter_aliases, l:i)
      endif
    endfunction
  endif

  let b:undo_ftplugin .= 'call MyLiquidFtpluginUndo()'
endif
