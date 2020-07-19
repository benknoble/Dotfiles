if exists('g:loaded_leader')
  finish
endif
let g:loaded_leader = 1

" Set <Leader> used for mappings
let mapleader = " "
" And <LocalLeader> for buffer mappings
let maplocalleader = '\'

call popsikey#register('<Leader>c', [
      \ #{ key: 'l', info: 'clear line', action: '0D', },
      \ #{
      \   key: 'w',
      \   info: 'refactor word',
      \   action: ":let @/ = expand('<cword>')\<CR>cgn",
      \ },
      \ ],
      \ #{
      \ title: ' Change ',
      \ })

call popsikey#register('<Leader>f', [
      \ #{ key: 's', info: 'save', action: ":write\<CR>", },
      \ #{ key: 'q', info: 'quit', action: ":quit\<CR>", },
      \ #{ key: 'Q', info: 'quit all', action: ":qall\<CR>", },
      \ #{ key: 'z', info: 'suspend', action: ":suspend\<CR>", },
      \ #{
      \   key: 'v',
      \   info: 'edit vimrc',
      \   action: ":vsplit $MYVIMRC\<CR>",
      \ },
      \ #{
      \   key: 'r',
      \   info: 'reload',
      \   action: ":if exists(':Reload') | Reload | endif\<CR>",
      \ },
      \ ],
      \ #{
      \ title: ' General menu ',
      \ })

call popsikey#register('<Leader>ee', [
      \ #{
      \   key: 'd',
      \   info: 'directory browser',
      \   action: ":Explore\<CR>",
      \   flags: '',
      \ },
      \ #{ key: 'e', info: 'edit file', action: ':edit ', },
      \ #{ key: 's', info: 'split file', action: ':split ', },
      \ #{ key: 'v', info: 'vsplit file', action: ':vsplit ', },
      \ #{ key: 't', info: 'tabedit file', action: ':tabedit ', },
      \ #{ key: 'f', info: 'find files', action: ':find **/*', },
      \ #{ key: 'b', info: 'buffer', action: ":buffer \<C-d>", },
      \ ],
      \ #{
      \ title: ' Edit files ',
      \ })

call popsikey#register('<Leader>ew', [
      \ #{ key: 'e', info: 'edit file', action: ':edit %%', flags: '', },
      \ #{ key: 's', info: 'split file', action: ':split %%', flags: '', },
      \ #{ key: 'v', info: 'vsplit file', action: ':vsplit %%', flags: '', },
      \ #{ key: 't', info: 'tabedit file', action: ':tabedit %%', flags: '', },
      \ ],
      \ #{
      \ title: ' Edit files in current directory ',
      \ })

" Edit alternate file
nnoremap <Leader>` <C-^>
" Quickly edit vimrc
nnoremap <Leader>v :vsplit $MYVIMRC<CR>

" Trigger the command line window
nnoremap <Leader>; q:

call popsikey#register('<Leader>/', [
      \ #{ key: '/', info: 'magic search', action: '/\v', },
      \ #{ key: '?', info: 'magic search', action: '?\v', },
      \ #{
      \   key: 'i',
      \   info: 'included word under cursor',
      \   action: ":call find#included_word(expand('<cword>'))\<CR>",
      \ },
      \ #{
      \   key: 'd',
      \   info: 'macro-defined word under cursor',
      \   action: ":call find#macrod_word(expand('<cword>'))\<CR>",
      \ },
      \ #{ key: 't', info: 'tag', action: ':tjump /', },
      \ #{ key: 'g', info: 'grep', action: ':grep ', },
      \ #{ key: 'v', info: 'vimgrep', action: ':vimgrep ', },
      \ #{
      \   key: 'G',
      \   info: 'global',
      \   action: ":global //#\<Left>\<Left>",
      \ },
      \ #{
      \   key: 'B',
      \   info: 'bad words search',
      \   action: ":Badsearch\<CR>",
      \ },
      \ ],
      \ #{
      \ title: ' Search ',
      \ })

nnoremap <expr> <Leader>r exists(':Reload') ? ':Reload<CR>' : ''

nnoremap <leader>} dap}p
nnoremap <leader>{ dap{{p

function PrintTabsSpaces() abort
  return printf('%s: tabstop=%d softtabstop=%d shiftwidth=%d',
        \ &expandtab ? 'SPACES' : 'TABS',
        \ &tabstop,
        \ &softtabstop,
        \ &shiftwidth)
endfunction

" add t later
let g:popsikey_info_id = popsikey#register('<Leader><Leader>', [
      \ #{
      \   key: 'c',
      \   info: 'cursor',
      \   action: ":call cursor#blink(0.2)\<CR>",
      \ },
      \ #{
      \   key: 't',
      \   info: 'spacing',
      \   action: ":echomsg PrintTabsSpaces()\<CR>",
      \ },
      \ ],
      \ #{
      \ title: ' Information ',
      \ })

nnoremap <Leader>l :call list#swap()<CR>
xnoremap <Leader>l :call list#swap('visual')<CR>
