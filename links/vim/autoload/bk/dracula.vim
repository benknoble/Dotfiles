function bk#dracula#should_abort(...) abort
  let drac = exists('*dracula#should_abort') ? call('dracula#should_abort', a:000) : v:true
  let drac_pro = exists('*dracula_pro#should_abort') ? call('dracula_pro#should_abort', a:000) : v:true
  return drac && drac_pro
endfunction
