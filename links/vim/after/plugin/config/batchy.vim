" plugin is opt/batchy package
" I don't need it all the time, so hot-load it when I do
" This command will be overwritten, since batchy uses :command!
command -nargs=* Batchy packadd batchy | Batchy <args>
command BatchyHere Batchy enew | setlocal noswapfile buftype=nofile bufhidden=hide nowrap
