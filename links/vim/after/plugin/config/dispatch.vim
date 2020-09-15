if ! exists('g:loaded_dispatch')
  finish
endif

if has('job')
  " :help dispatch-strategies
  let g:dispatch_no_tmux_make = 1
endif
