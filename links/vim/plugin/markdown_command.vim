if exists('g:loaded_markdown_command')
  finish
endif
let g:loaded_markdown_command = 1

command Markdown set filetype=markdown
