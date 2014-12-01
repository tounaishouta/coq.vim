" Vim syntax file
" Language:    Coq
" Maintainer:  IjvLHsoZ6L
" Last Change: 2014 Nov 18

if exists('b:current_syntax')
  finish
endif

syntax case match

syntax match   coqSection     /\v<Section>|<End>/
      \ nextgroup=coqSectionName skipwhite
syntax match   coqAssumption  /\v<Variable>|<Hypothesis>/
      \ nextgroup=coqDefinedName skipwhite
syntax match   coqDefinition  /\v<Definition>|<Inductive>|<Fixpoint>|<Record>/
      \ nextgroup=coqDefinedName skipwhite
syntax match   coqAssertion   /\v<Theorem>|<Lemma>|<Corollary>|<Proposition>/
      \ nextgroup=coqDefinedName skipwhite
syntax match   coqSectionName /\v\h(\w|')*/ contained
syntax match   coqDefinedName /\v\h(\w|')*/ contained
syntax keyword coqProof       Goal Proof Qed Abort
syntax keyword coqCommand     Check Print Eval Search About SearchAbout Require Import Export Quit
syntax keyword coqType        Type Set Prop
syntax keyword coqKeyword     forall exists match with end if then else let in fun fix
syntax match   coqOperator    '\V:=\|:\||\|=>\|->\|/\\\|\\/\|<->\|.'
syntax match   coqNumber      /\v(<|-)\d+/
syntax region  coqString      start=/"/ skip=/\\"/ end=/"/
syntax region  coqComment     start=/(\*/ end=/\*)/

highlight link coqSection     coqSpecial
highlight link coqAssumption  coqSpecial
highlight link coqDefinition  coqSpecial
highlight link coqAssertion   coqSpecial
highlight link coqProof       coqSpecial
highlight link coqSectionName coqIdentifier
highlight link coqDefinedName coqIdentifier
highlight link coqCommand     coqSpecial
highlight link coqKeyword     coqStatement
highlight link coqOperator    coqStatement
highlight link coqString      coqConstant
highlight link coqNumber      coqConstant

highlight default link coqSpecial    Special
highlight default link coqIdentifier Identifier
highlight default link coqType       Type
highlight default link coqStatement  Statement
highlight default link coqConstant   Constant
highlight default link coqComment    Comment

let b:current_syntax = 'coq'
