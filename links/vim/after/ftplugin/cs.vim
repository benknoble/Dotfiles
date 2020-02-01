" Vim filetype plugin
" Language:              cs
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
nnoremap <buffer> ]d :OmniSharpGotoDefinition<CR>
nnoremap <buffer> [d :OmniSharpGotoDefinition<CR>
nnoremap <buffer> ]<C-d> :OmniSharpPreviewDefinition<CR>
nnoremap <buffer> [<C-d> :OmniSharpPreviewDefinition<CR>

nnoremap <buffer> ]i :OmniSharpFindImplementations<CR>
nnoremap <buffer> [i :OmniSharpFindImplementations<CR>
nnoremap <buffer> ]<C-i> :OmniSharpPreviewImplementation<CR>
nnoremap <buffer> [<C-i> :OmniSharpPreviewImplementation<CR>

nnoremap <buffer> <localleader>* :OmniSharpFindUsages<CR>
nnoremap <buffer> <localleader>m :OmniSharpFindMembers<CR>

setlocal keywordprg=:OmniSharpDocumentation

nnoremap <buffer> == :OmniSharpCodeFormat<CR>

nnoremap <buffer> <localleader>t :OmniSharpRunTestsInFile<CR>
nnoremap <buffer> <localleader>a :OmniSharpGetCodeActions<CR>

let b:interpreter = 'csharp'

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \   'keywordprg',
      \ ],
      \ 'maps': [
      \   '<localleader>*',
      \   '<localleader>a',
      \   '<localleader>m',
      \   '<localleader>t',
      \   '==',
      \   '[<C-d>',
      \   '[<C-i>',
      \   '[d',
      \   '[i',
      \   ']<C-d>',
      \   ']<C-i>',
      \   ']d',
      \   ']i',
      \   'gd',
      \ ],
      \ })
