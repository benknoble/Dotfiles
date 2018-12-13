if ! exists(':Explore')
  finish
endif

" Make netrw use a long listing
let g:netrw_liststyle=1
" Don't display baner
let g:netrw_banner=0
" Use my cursorline/column settings
let g:netrw_cursor=0
" Hide things not tracked by gitignore
" let g:netrw_list_hide=netrw_gitignore#Hide()
" Something is going screwy here^
