" Vim syntax file
" Language: Plim
" Maintainer: Keith Yang <i@keitheis.org>
" Version:  1
" Last Change:  2013 Apr 15
" TODO: No plan. Welcome to fork.

" Quit when a syntax file is already loaded.
if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'plim'
endif

"" Allows a per line syntax evaluation.
"let b:python_no_expensive = 1
" Include Python syntax highlighting
syn include @plimPythonTop syntax/python.vim
unlet! b:current_syntax
" Include Sass syntax highlighting
syn include @plimSass syntax/sass.vim
unlet! b:current_syntax
" Include Scss syntax highlighting
syn include @plimScss syntax/scss.vim
unlet! b:current_syntax
" Include Coffeescript syntax highlighting, ignoring errors if it's missing
silent! syn include @plimCoffee syntax/coffee.vim
unlet! b:current_syntax

" Include HTML
syn include @plimHtml syntax/scss.vim
unlet! b:current_syntax

setlocal iskeyword+=:

syn match plimBegin  "^\s*\(&[^= ]\)\@!" nextgroup=plimTag,plimClassChar,plimIdChar,plimPython

syn region  pythonCurlyBlock start="{" end="}" contains=@plimPythonTop contained
syn cluster plimPythonTop    add=pythonCurlyBlock

syn cluster plimComponent contains=plimClassChar,plimIdChar,plimWrappedAttrs,plimPython,plimAttr

syn keyword plimDocType        contained html 5 1.1 strict frameset mobile basic transitional
syn match   plimDocTypeKeyword "^\s*\(doctype\)\s\+" nextgroup=plimDocType

"syn match plimTag       "\w\+\(:\w\+\)\=" contained contains=htmlTagName,htmlSpecialTagName nextgroup=@plimComponent
syn match plimTag       "\w\+" contained contains=htmlTagName nextgroup=@plimComponent
syn match plimIdChar    "#{\@!"           contained nextgroup=plimId
syn match plimId        "\%(\w\|-\)\+"    contained nextgroup=@plimComponent
syn match plimClassChar "\."              contained nextgroup=plimClass
syn match plimClass     "\%(\w\|-\)\+"    contained nextgroup=@plimComponent
syn match plimInlineTagChar "\s*:\s*"      contained nextgroup=plimTag,plimClassChar,plimIdChar

syn region plimWrappedAttrs matchgroup=CurlyBracket start="\s*{\s*" skip="}\s*\""  end="\s*}\s*"  contained contains=plimAttr nextgroup=plimPython
syn region plimWrappedAttrs matchgroup=SquareBracket start="\s*\[\s*" end="\s*\]\s*" contained contains=plimAttr nextgroup=plimPython
syn region plimWrappedAttrs matchgroup=Bracket start="\s*(\s*"  end="\s*)\s*"  contained contains=plimAttr nextgroup=plimPython

syn match plimAttr "\s*\%(\w\|-\)\+\s*" contained contains=htmlArg nextgroup=plimAttrAssignment
syn match plimAttrAssignment "\s*=\s*" contained nextgroup=plimWrappedAttrValue,plimAttrString

syn region plimWrappedAttrValue matchgroup=CurlyBracket start="{" end="}" contained contains=plimAttrString,@plimPythonTop nextgroup=plimAttr,plimPython
syn region plimWrappedAttrValue matchgroup=SquareBracket start="\[" end="\]" contained contains=plimAttrString,@plimPythonTop nextgroup=plimAttr,plimPython
syn region plimWrappedAttrValue matchgroup=Bracket start="(" end=")" contained contains=plimAttrString,@plimPythonTop nextgroup=plimAttr,plimPython

syn region plimAttrString start=+\s*"+ skip=+\%(\\\\\)*\\"+ end=+"\s*+ contained contains=plimInterpolation,plimInterpolationEscape nextgroup=plimAttr,plimPython
syn region plimAttrString start=+\s*'+ skip=+\%(\\\\\)*\\"+ end=+'\s*+ contained contains=plimInterpolation,plimInterpolationEscape nextgroup=plimAttr,plimPython

syn region plimInnerAttrString start=+\s*"+ skip=+\%(\\\\\)*\\"+ end=+"\s*+ contained contains=plimInterpolation,plimInterpolationEscape nextgroup=plimAttr
syn region plimInnerAttrString start=+\s*'+ skip=+\%(\\\\\)*\\"+ end=+'\s*+ contained contains=plimInterpolation,plimInterpolationEscape nextgroup=plimAttr

"syn region plimInterpolation matchgroup=plimInterpolationDelimiter start="#{" end="}" contains=@hamlRubyTop containedin=javascriptStringS,javascriptStringD,slimWrappedAttrs
syn match  plimInterpolationEscape "\\\@<!\%(\\\\\)*\\\%(\\\ze#{\|#\ze{\)"

syn region plimPython matchgroup=plimPythonOutputChar start="\s*[=]\==[']\=" skip=",\s*$" end="$" contained contains=@plimPythonTop keepend
syn region plimPython matchgroup=plimPythonChar       start="\s*-"           skip=",\s*$" end="$" contained contains=@plimPythonTop keepend

syn match plimComment /^\(\s*\)[/].*\(\n\1\s.*\)*/
syn match plimText    /^\(\s*\)[`|'].*\(\n\1\s.*\)*/

syn match plimPy /^\s*-\s*py\(\|thon\)/ contained
syn match plimFilter /\s*\w\+:\s*/                            contained
syn match plimJs     /^\(\s*\)\<javascript:\>.*\(\n\1\s.*\)*/ contains=@htmlJavaScript,plimFilter
syn match plimCoffee /^\(\s*\)\<coffee:\>.*\(\n\1\s.*\)*/     contains=@plimCoffee,plimFilter
syn match plimSass   /^\(\s*\)\<sass:\>.*\(\n\1\s.*\)*/       contains=@plimSass,plimFilter
syn match plimScss   /^\(\s*\)\<scss:\>.*\(\n\1\s.*\)*/       contains=@plimScss,plimFilter
syn match plimPythonBlock     /^\(\s*\)-\s*py\(\|thon\)\>.*\(\n\1\s.*\)*/         contains=@plimPythonTop,plimFilter,plimPy

syn match plimIEConditional "\%(^\s*/\)\@<=\[\s*if\>[^]]*]" contained containedin=plimComment

hi def link plimAttrString                String
hi def link plimBegin                     String
hi def link plimClass                     Type
hi def link plimClassChar                 Dot
hi def link plimComment                   Comment
hi def link plimDocType                   Identifier
hi def link plimDocTypeKeyword            Keyword
hi def link plimFilter                    Keyword
hi def link plimIEConditional             SpecialComment
hi def link plimId                        Identifier
hi def link plimIdChar                    Identifier
hi def link plimInnerAttrString           String
hi def link plimInterpolationDelimiter    Delimiter
hi def link plimPy                        Statement
hi def link plimPythonChar                Special
hi def link plimPythonOutputChar          Special
hi def link plimTag                       Special
hi def link plimText                      String
hi def link plimWrappedAttrValueDelimiter Delimiter
hi def link plimWrappedAttrsDelimiter     Delimiter
hi def link plimInlineTagChar             Delimiter

let b:current_syntax = "plim"
