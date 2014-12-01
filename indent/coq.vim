" Vim indent file
" Language:    Coq
" Maintainer:  IjvLHsoZ6L
" Last Change: 2014 Nov 18

" Only load this indent file when no other was loaded.
if exists('b:did_indent')
  finish
endif
let b:did_indent = 1

setlocal expandtab
setlocal indentexpr=GetCoqIndent()
setlocal indentkeys=!^F,o,O
setlocal indentkeys+=0=end,0=Qed,0=End
setlocal indentkeys+=\|,),},]
setlocal nolisp
setlocal nosmartindent

" Only define the function once.
if exists('*GetCoqIndent')
  finish
endif

function! s:matchcount(line, pat)
  let mcount = 0
  let mstart = 0
  while 1
    let mend = matchend(a:line, a:pat, mstart)
    if mend == -1
      return mcount
    endif
    let mcount += 1
    let mstart = mend
  endwhile
endfunction

function! s:prevmatch(lnum, pat, negpat)
  let lnum = a:lnum
  let stack = 1
  while 1
    if lnum == 0
      throw 'prevmatch: Not found.'
    endif
    let stack -= s:matchcount(getline(lnum), a:pat)
    let stack += s:matchcount(getline(lnum), a:negpat)
    if stack == 0
      return lnum
    endif
    let lnum = prevnonblank(lnum - 1)
  endwhile
endfunction

function GetCoqIndent()

  let lnum = v:lnum
  let line = getline(lnum)

  let plnum = prevnonblank(lnum - 1)
  let pline = getline(plnum)

  if plnum == 0
    return 0

  elseif line =~ '\v\C^\s*<end>'
    return indent(s:prevmatch(plnum, '\v\C<match>', '\v\C<end>'))

  elseif line =~ '\v\C^\s*<Qed>'
    return indent(s:prevmatch(plnum, '\v\C<Proof>', '\v\C<Qed>'))

  elseif line =~ '\v\C^\s*<End>'
    return indent(s:prevmatch(plnum, '\v\C<Section>', '\v\C<End>'))

  elseif line =~ '\v^\s*\|'
    let pmlnum = s:prevmatch(plnum, '\v\C<match>|<Inductive>', '\v\C<end>')
    let pmline = getline(pmlnum)
    if pmline =~ '\v\C^\s*<match>'
      return indent(pmlnum)
    else
      return indent(pmlnum) + &shiftwidth
    endif

  elseif line =~ '\v^\s*\)'
    return indent(s:prevmatch(plnum, '\v\(', '\v\)'))

  elseif line =~ '\v^\s*\}'
    return indent(s:prevmatch(plnum, '\v\{', '\v\}'))

  elseif line =~ '\v^\s*\]'
    return indent(s:prevmatch(plnum, '\v\[', '\v\]'))

  elseif pline !~ '\v(\.|;)\s*$'
    return indent(plnum) + &shiftwidth

  else
    try
      return indent(s:prevmatch(plnum,
            \ '\v\C<Proof>|<Section>|\(|\{|\[',
            \ '\v\C<Qed>|<End>|\)|\}|\]')) + &shiftwidth
    catch 'prevmatch: Not found.'
      return 0
    endtry

  endif
endfunction
