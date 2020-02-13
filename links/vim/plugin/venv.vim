if exists('g:loaded_venv')
  finish
endif
let g:loaded_venv = 1

if has('python3') && exists('$VIRTUAL_ENV')
  function! s:load_venv() abort
    python3 << EOF
import os
# sys already imported

venv = os.environ['VIRTUAL_ENV']
major = sys.version_info.major
minor = sys.version_info.minor
lib_dir = os.path.join(venv, 'lib', f'python{major}.{minor}', 'site-packages')

sys.prefix = venv
sys.path.insert(0, lib_dir)
EOF
  endfunction
  call s:load_venv()
endif
