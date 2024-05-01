vim9script

export def QuickfixContextFiles(entry: number): list<string>
  var qf = getqflist({context: 0, idx: entry})
  if get(qf, 'idx', 0) > 0 &&
      type(get(qf, 'context')) == type({}) &&
      type(get(qf.context, 'items')) == type([]) &&
      qf.idx <= len(qf.context.items)
    var diff = get(qf.context.items[qf.idx - 1], 'diff', [])
    return diff->mapnew((k, v) => v.filename)->reverse()
  endif
  return []
enddef

export def OpenQuickfixContextFiles(entry: number)
  QuickfixContextFiles(entry)->foreach((k, v) => {
    execute (k == 0 ? 'rightbelow' : 'leftabove') 'diffsplit' fnameescape(v)
    wincmd p
  })
enddef

export def OpenCurrentQuickfixContextFiles()
  OpenQuickfixContextFiles(0)
enddef
