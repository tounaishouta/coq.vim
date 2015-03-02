" Call coqtop from vim
" Language:    Coq
" Maintainer:  TOUNAI Shouta <tounai.shouta@gmail.com>
" Last Change: 2014 Dec 15
" License:     This file is placed in the public domain.

" Only do this when not done yet for this buffer
if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

" save cpoptions
let s:saved_cpoptions = &cpoptions
set cpoptions&vim

" optional key bind
nnoremap <buffer> <silent> ,, :CoqRunToCursor<CR>

command! CoqRunToCursor call <sid>runtocursor()

function! s:runtocursor()

  let input = join(getline(1, '.'), "\n")

  let output = split(system('coqtop', input), '\v\n\zs((\w|'')+ \< )\1*')

  " get last non-empty line of output
  let last = ''
  for line in output
    if line !~ '\v^\_s*$'
      let last = line
    endif
  endfor
  let last = substitute(last, '\v^\_\s*', '', '')
  let last = substitute(last, '\v\_\s*$', '', '')

  let curbuf = bufnr('%')

  let nr = bufwinnr('__coq_ide__')
  if nr == -1
    silent! execute '10split' '__coq_ide__'
    setlocal buftype=nofile
    setlocal noswapfile
    setlocal nonumber
    setlocal nolist
  else
    execute nr 'wincmd w'
  endif

  silent! execute '%delete'
  call append(0, split(last, '\n'))
  silent! execute '$delete'
  call cursor(1, 1)

  execute bufwinnr(curbuf) 'wincmd w'

endfunction

" restore cpoptions
let &cpoptions = s:saved_cpoptions
unlet s:saved_cpoptions
