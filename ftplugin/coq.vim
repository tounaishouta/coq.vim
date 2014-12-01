function! s:runtocursor()

  if &autowrite
    write
  endif

  let ip = join(getline(1, '.'), "\n")

  if empty(ip)
    return
  endif

  let op = system('coqtop -emacs', ip)

  for opl in split(op, '\m\_\s*<prompt>.\{-}</prompt>\_\s*')
    let last = opl
  endfor

  let cur = winnr()
  let winname = '__coq_ide__'
  let nr = bufwinnr(winname)
  if nr == -1
    silent! execute 10 'split' winname
    setlocal buftype=nofile
    setlocal noswapfile
    setlocal nolist
  else
    execute nr 'wincmd w'
  endif
  silent! execute '%delete'
  call append(0, split(last, '\n'))
  call cursor(1, 1)
  execute cur 'wincmd w'

endfunction

command! CoqRunToCursor call <sid>runtocursor()

nnoremap <buffer> <silent> ,, :CoqRunToCursor<CR>
