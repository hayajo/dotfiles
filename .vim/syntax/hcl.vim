" Vim syntax file
" Language: HCL
" Filenames: *.{tf}

if exists("b:current_syntax")
  finish
endif

unlet! b:current_syntax

" Syntax
syn keyword Todo TODO
syn match hclString "\".\{-}\""
syn region hclComment display oneline start='\%\(^\|\s\)#' end='$' contains=Todo

" Highlight
hi link hclString String
hi link hclComment Comment

let b:current_syntax = "hcl"

" vim:set sw=2:
