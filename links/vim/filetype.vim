" My filetype file
if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  au BufRead,BufNewFile gitconfig,.gitconfig.local setfiletype gitconfig
augroup END
