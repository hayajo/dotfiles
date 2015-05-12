" Vim syntax file
" Language: present (http://godoc.org/code.google.com/p/go.tools/present)
" Filenames: *.{article,slide}

if exists("b:current_syntax")
  finish
endif

unlet! b:current_syntax

" Syntax
syn keyword Todo TODO
syn region presentSection start="^*\+ "hs=e+1 end="$"he=s-1
syn match presentBullet "^-\+ "
syn region presentPrefomat start="^\s\+" end="$"
syn match presentCode "^\.\(code\|play\|image\|iframe\|link\|html\|caption\)" contains=presentOption,presentLink
syn match presentOption "\s\+-\S\+"
syn match presentLink "https\?://[0-9a-zA-Z_/:%#\$&\?\(\)~\.=\+\-]\+"
syn region presentComment start="^#" end="$" contains=Todo

" Highlight
hi link presentSection Identifier
hi link presentBullet Keyword
hi link presentPrefomat PreProc
hi link presentCode Function
hi link presentOption Type
hi link presentLink Underlined
hi link presentComment Comment

let b:current_syntax = "present"

" vim:set sw=2:
