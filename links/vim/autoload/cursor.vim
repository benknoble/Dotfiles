function cursor#blink(time) abort
  set cursorline cursorcolumn
  redraw
  exec 'sleep ' . float2nr(a:time * 1000) . 'm'
  set nocursorline nocursorcolumn
  redraw
endfunction
