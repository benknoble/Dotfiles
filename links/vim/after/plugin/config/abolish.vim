if !exists('g:loaded_abolish')
  finish
endif

call popsikey#extend(g:popsikey_change_id, [
      \ #{ key: 'm', info: 'MixedCase', action: 'crm', flags: 'm' },
      \ #{ key: 'c', info: 'camelCase', action: 'crc', flags: 'm' },
      \ #{ key: 's', info: 'snake_case', action: 'crs', flags: 'm' },
      \ #{ key: 'u', info: 'UPPER_CASE', action: 'cru', flags: 'm' },
      \ #{ key: '-', info: 'dash-case', action: 'cr-', flags: 'm' },
      \ #{ key: '.', info: 'dot.case', action: 'cr.', flags: 'm' },
      \ #{ key: ' ', info: 'space case', action: 'cr ', flags: 'm' },
      \ #{ key: 't', info: 'Title Case', action: 'crt', flags: 'm' },
      \ ], #{})
