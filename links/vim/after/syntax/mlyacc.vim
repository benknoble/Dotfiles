" Maintainer: Jake Zimmerman <jake@zimmerman.io>
" License: MIT License
"
" Description:
"   Adds syntax highlighting for *.mlyacc (ML Yacc) files.
"

if version < 600
  syntax clear
elseif exists('b:current_syntax')
  finish
endif

" ----- Vim Syntax ----------------------------------------------------------
syn include @mlyaccExpr syntax/sml.vim

" We need to hand pick a few "well-behaved" groups so that SML doesn't try to
" tyrannize the rest of our syntax file with it's greedy matching.
syn cluster mlyaccSafeSML contains=smlLCIdentifier,smlConstructor,smlKeyChar,smlKeyword,smlOperator,smlBoolean,smlString,smlType,smlModPath

" ----- Comments ------------------------------------------------------------
syn region mlyaccComment start="(\*" end="\*)" contains=mlyaccComment,mlyaccTodo
syn keyword mlyaccTodo contained TODO FIXME XXX


" ----- User Declarations ---------------------------------------------------
syn region mlyaccUserDeclarations start="^\(\h\+\s\|%{\)" end="^\ze%%\s*$" skipempty skipwhite nextgroup=mlyaccDeclarations contains=@mlyaccExpr


" ----- Command Declarations ------------------------------------------------
syn region mlyaccDeclarations matchgroup=mlyaccSeparator start="^%%\s*$" end="^%\ze%\s*$" contains=mlyaccDirective,mlyaccComment,@mlyaccSafeSML skipempty skipwhite nextgroup=mlyaccRules keepend

syn match mlyaccDirective '^%\(arg\|eop\|header\|keyword\|left\|name\)\>' contained
syn match mlyaccDirective '^%\(nodefault\|nonassoc\|nonterm\|noshift\)\>' contained
syn match mlyaccDirective '^%\(pos\|prefer\|pure\|right\|start\)\>' contained
syn match mlyaccDirective '^%\(subst\|term\|value\|verbose\)\>' contained


" ----- Production Rules ----------------------------------------------------
syn region mlyaccRules matchgroup=mlyaccSeparator start="%\s*$"me=e-1 end="\%$" contained contains=mlyaccRuleCode,mlyaccRuleName,mlyaccRuleSep,mlyaccComment,smlLCIdentifier,smlConstructor
syn match mlyaccRuleCode '(.*)' contained contains=@mlyaccExpr
syn match mlyaccRuleName '^\w\+\ze\s*:' contained
syn match mlyaccRuleSep '\(|\|:\)' contained


" ----- Highlighting Groups -------------------------------------------------
hi def link mlyaccComment     Comment
hi def link mlyaccTodo        Todo

hi def link mlyaccSeparator   Special

hi def link mlyaccDirective   Preproc

hi def link mlyaccRuleName    Identifier
hi def link mlyaccRuleSep     Operator


let b:current_syntax = 'mlyacc'



" -------------------------------------
" TODO(jez) These rules are semantically better, but they're complicated and
"           only yield marginal benefits to the syntax highlighting. Though,
"           with some work they could bring significant benefit.
"syn region mlyaccDeclarations matchgroup=mlyaccSeparator start="^%%\s*$" end="^%\ze%\s*$" contains=mlyaccDeclarationCommand,mlyaccComment skipempty skipwhite nextgroup=mlyaccRules keepend
"syn match mlyaccDeclarationCommand '^%\w\+\>\_[^%]*' contained contains=mlyaccDirective,@mlyaccExpr
"syn match mlyaccDeclarationNullaryCommand '^%\(nodefault\|pure\|verbose\)\>' contained
"syn match mlyaccDeclarationIdCommand '^%\(name\|start\)\>' contained nextgroup=smlLCIdentifier,smlConstructor skipwhite
"syn match mlyaccDeclarationIdListCommand '^%\(left\|right\|nonassoc\|eop\|noshift\|keyword\|prefer\)\>' contained nextgroup=mlyaccDeclarationIdList skipwhite
"syn match mlyaccDeclarationIdList "\_[^%]+" contained contains=smlLCIdentifier,smlConstructor skipwhite
"syn match mlyaccDeclarationTypeCommand '^%\(pos\)\>' contained nextgroup=smlType skipwhite
"syn match mlyaccDeclarationCodeCommand '^%\(arg\|header\)\>' contained nextgroup=mlyaccDeclarationCode
"syn match mlyaccDeclarationCode '.*$' contained contains=@mlyaccSafeSML
" -------------------------------------
