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

let b:undo_ftplugin = bk#ftplugin#undo({
      \ 'opts': [
      \   'keywordprg',
      \ ],
      \ 'maps': [
      \   ['n', '<localleader>*'],
      \   ['n', '<localleader>a'],
      \   ['n', '<localleader>m'],
      \   ['n', '<localleader>t'],
      \   ['n', '=='],
      \   ['n', '[<C-d>'],
      \   ['n', '[<C-i>'],
      \   ['n', '[d'],
      \   ['n', '[i'],
      \   ['n', ']<C-d>'],
      \   ['n', ']<C-i>'],
      \   ['n', ']d'],
      \   ['n', ']i'],
      \   ['n', 'gd'],
      \ ],
      \ })
