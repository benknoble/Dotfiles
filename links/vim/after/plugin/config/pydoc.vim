if ! exists(':Pydoc')
  finish
endif

" let g:pydoc_perform_mappings = 0
let g:pydoc_cmd = 'python -m pydoc'
