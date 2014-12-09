" Vim plugin file
" Language:    Coq
" Maintainer:  IjvLHsoZ6L
" Last Change: 2014 Dec 1

" Only do this when not done yet for this buffer
if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

" optional key bind
nnoremap <buffer> <silent> ,, :CoqRunToCursor<CR>

command! CoqRunToCursor call <sid>runtocursor()

function! s:runtocursor()

  let input = join(getline(1, '.'), "\n")

  let output = split(system('coqtop', input), '\v\n\zs(\w+ \< )\1*')

  " get last non-empty line of output
  let last = ''
  for line in output
    if line !~ '\v^\_\s*$'
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
