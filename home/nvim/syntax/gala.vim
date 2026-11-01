" Gala syntax highlighting (regex-based: no tree-sitter grammar exists yet)
if exists("b:current_syntax")
  finish
endif

syn keyword galaKeyword val var bind also use func type struct interface
      \ match case if else for range return import package sealed default
      \ opaque embed
syn keyword galaType any bool byte rune error int int8 int16 int32 int64
      \ uint uint8 uint16 uint32 uint64 uintptr float32 float64 complex64
      \ complex128 string
syn keyword galaBoolean true false

syn match galaFunction "\<func\s\+\zs[A-Za-z_][A-Za-z0-9_]*"
syn match galaTypeName "\<[A-Z][A-Za-z0-9_]*\>"

syn match galaNumber "\<0[xX][0-9a-fA-F_]\+\>"
syn match galaNumber "\<0[bB][01_]\+\>"
syn match galaNumber "\<[0-9][0-9_]*\(\.[0-9_]\+\)\?\([eE][+-]\?[0-9]\+\)\?\>"

syn region galaString start=/\<[sf]\?"/ end=/"/ skip=/\\"/ contains=galaEscape
syn region galaRawString start=/`/ end=/`/
syn region galaCharacter start=/'/ end=/'/ skip=/\\'/
syn match galaEscape "\\[\\\"'ntr]" contained

syn match galaOperator "[+\-*/%&|^<>=!]=*"

syn match galaLineComment "//.*" contains=galaTodo
syn region galaBlockComment start="/\*" end="\*/" contains=galaTodo
syn keyword galaTodo TODO FIXME XXX NOTE contained

hi def link galaKeyword Keyword
hi def link galaType Type
hi def link galaTypeName Type
hi def link galaBoolean Boolean
hi def link galaFunction Function
hi def link galaNumber Number
hi def link galaString String
hi def link galaRawString String
hi def link galaCharacter Character
hi def link galaEscape SpecialChar
hi def link galaLineComment Comment
hi def link galaBlockComment Comment
hi def link galaTodo Todo
hi def link galaOperator Operator

let b:current_syntax = "gala"
