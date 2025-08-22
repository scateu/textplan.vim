if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if version < 508
  command! -nargs=+ HiLink hi link <args>
else
  command! -nargs=+ HiLink hi def link <args>
endif


syn match    markdownHeader1     "^# .*$"
syn match    markdownHeader2     "^## .*$"
syn match    markdownHeader3     "^### .*$"
syn match    markdownHeader4     "^#### .*$"
syn match    markdownHeader5     "^##### .*$"
syn match    markdownHeader6     "^###### .*$"
syn match    markdownHeader7     "^####### .*$"


HiLink markdownHeader1 Title
HiLink markdownHeader2 Constant
HiLink markdownHeader3 Identifier
HiLink markdownHeader4 Statement
HiLink markdownHeader5 PreProc
HiLink markdownHeader6 Type
HiLink markdownHeader7 Special

syn sync fromstart

let b:current_syntax = "textplan"

delcommand HiLink
