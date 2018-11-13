" My filetype file
if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  au BufRead,BufNewFile gitconfig,.gitconfig.local setfiletype gitconfig
  au BufRead,BufNewFile Jenkinsfile* setfiletype groovy
augroup END
