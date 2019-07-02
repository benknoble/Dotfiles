if exists('g:loaded_statbadge')
  finish
endif
let g:loaded_statbadge = 1

let s:badges = {
      \ 'experimental': [
      \   'This project is considered experimental',
      \   'https://img.shields.io/badge/status-experimental-critical.svg',
      \   'https://benknoble.github.io/status/experimental/'
      \   ],
      \ 'stable': [
      \   'This project is considered stable',
      \   'https://img.shields.io/badge/status-stable-success.svg',
      \   'https://benknoble.github.io/status/stable/'
      \   ],
      \ 'finished': [
      \   'This project is considered finished',
      \   'https://img.shields.io/badge/status-finished-success.svg',
      \   'https://benknoble.github.io/status/finished/'
      \   ],
      \ 'archived': [
      \   'This project is archived',
      \   'https://img.shields.io/badge/status-archived-critical.svg',
      \   'https://benknoble.github.io/status/archived/'
      \   ],
      \ 'personal': [
      \   'This project is personal',
      \   'https://img.shields.io/badge/status-personal-important.svg',
      \   'https://benknoble.github.io/status/personal/'
      \   ]
      \ }

function! s:make_badge(badge) abort
  " this will fail if badge not in badges
  let [l:text, l:img, l:link] = s:badges[a:badge]
  return markdown#img_link(l:text, l:img, l:link)
endfunction

command -bar StatusExperimental put =s:make_badge('experimental')
command -bar StatusStable put =s:make_badge('stable')
command -bar StatusFinished put =s:make_badge('finished')
command -bar StatusArchived put =s:make_badge('archived')
command -bar StatusPersonal put =s:make_badge('personal')
