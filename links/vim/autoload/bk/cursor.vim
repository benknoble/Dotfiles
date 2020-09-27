function bk#cursor#blink(time) abort
  call bk#cursor#hl_on()
  let time_in_ms = float2nr(a:time * 1000)
  if has('timers')
    let _ = timer_start(time_in_ms, {_ -> bk#cursor#hl_off()})
  else
    exec 'sleep'  time_in_ms  'm'
    call bk#cursor#hl_off()
  endif
endfunction

function bk#cursor#hl_on() abort
  set cursorline cursorcolumn
  redraw
endfunction

function bk#cursor#hl_off() abort
  set nocursorline nocursorcolumn
  redraw
endfunction
