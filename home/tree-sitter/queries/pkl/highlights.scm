; Pkl syntax highlighting for tree-sitter.
;
; Derived from https://github.com/franckrasolo/Pkl.sublime-syntax
; (the source of truth for bat's rendering) and mapped onto the node types
; of https://github.com/apple/tree-sitter-pkl.
;
; Ordering rule: the tree-sitter highlighter keeps the LAST capture that
; matches a node, so the general `(identifier) @variable` comes first and the
; more specific identifier categories come after it. Do not reorder these
; sections without preserving that invariant.

; ---------------------------------------------------------------------------
; Identifiers (general first: later patterns win)
; ---------------------------------------------------------------------------

(identifier) @variable

; ---------------------------------------------------------------------------
; Operators
; ---------------------------------------------------------------------------

[
  "!"
  "!!"
  "!="
  "%"
  "&&"
  "*"
  "**"
  "+"
  "-"
  "->"
  "/"
  "<"
  "<="
  "="
  "=="
  ">"
  ">="
  "?"
  "?."
  "??"
  "|>"
  "~/"
  "..."
  "...?"
] @operator

; default-union marker `*` and union separator `|` (bat: peach / grey)
(defaultUnionType
  "*" @punctuation.definition.annotation)

(unionType
  "|" @punctuation.delimiter)

; ---------------------------------------------------------------------------
; Punctuation
; ---------------------------------------------------------------------------

[
  ","
  ":"
  "::"
  "|"
] @punctuation.delimiter

[
  "("
  ")"
  "["
  "]"
  "[["
  "]]"
  "{"
  "}"
] @punctuation.bracket

; member access / qualified names (bat: punctuation.accessor, teal)
"." @punctuation.accessor

; generic type arguments (bat: punctuation.definition.generic, teal);
; listed after the operator section so it wins over `<` / `>`
(typeArgumentList
  [
    "<"
    ">"
  ] @punctuation.definition.generic)

; annotation sigil
(annotation "@" @punctuation.definition.annotation)

; ---------------------------------------------------------------------------
; Interpolation boundaries — light pink (Neovim parity; bat leaves these grey)
; ---------------------------------------------------------------------------

(stringInterpolation
  [
    "\\("
    "\\#("
    "\\##("
    "\\###("
    "\\####("
    "\\#####("
    "\\######("
  ] @punctuation.special
  ")" @punctuation.special)

; ---------------------------------------------------------------------------
; Comments
; ---------------------------------------------------------------------------

[
  (lineComment)
  (blockComment)
] @comment

(docComment) @comment.documentation

(shebangComment) @keyword.directive

; ---------------------------------------------------------------------------
; Literals
; ---------------------------------------------------------------------------

[
  (stringConstant)
  (slStringLiteralExpr)
  (mlStringLiteralExpr)
] @string

(escapeSequence) @string.escape

(intLiteralExpr) @number

(floatLiteralExpr) @number.float

[
  (trueLiteralExpr)
  (falseLiteralExpr)
] @boolean

; null / NaN / Infinity (bat: constant.language, red)
(nullLiteralExpr) @constant.builtin

((identifier) @constant.builtin
  (#match? @constant.builtin "^(NaN|Infinity)$"))

; ---------------------------------------------------------------------------
; Keywords
; ---------------------------------------------------------------------------

[
  "abstract"
  "external"
  "for"
  "is"
  "let"
  "new"
  "out"
] @keyword

"function" @keyword.function

; bat renders these mauve, not teal
[
  "as"
  "in"
] @keyword.operator

[
  "typealias"
  "class"
  "module"
] @keyword.type

[
  "import"
  "import*"
  "amends"
  "extends"
] @keyword.import

[
  "when"
  "if"
  "else"
] @keyword.conditional

(modifier) @keyword.modifier

; read / read? / read* / throw / trace — reserved builtins
[
  "read"
  "read?"
  "read*"
  "throw"
  "trace"
] @keyword

; builtin value keywords
[
  (thisExpr)
  (outerExpr)
  "super"
] @variable.builtin

[
  (thisType)
  (moduleType)
  (nothingType)
  (unknownType)
] @keyword.type

; ---------------------------------------------------------------------------
; Types (bat: yellow)
; ---------------------------------------------------------------------------

(clazz
  (identifier) @type.definition)

(typeAlias
  (identifier) @type.definition)

(typeParameter
  (identifier) @type)

(declaredType
  (qualifiedIdentifier
    (identifier) @type))

; ---------------------------------------------------------------------------
; Functions and methods (bat: blue; definitions italic via the theme)
; ---------------------------------------------------------------------------

(classMethod
  (methodHeader
    (identifier) @function.method))

(objectMethod
  (methodHeader
    (identifier) @function.method))

; calls
(unqualifiedAccessExpr
  (identifier) @function.call
  .
  (argumentList))

(qualifiedAccessExpr
  (identifier) @function.method.call
  .
  (argumentList))

(superAccessExpr
  (identifier) @function.method.call
  .
  (argumentList))

; ---------------------------------------------------------------------------
; Parameters (bat: maroon)
; ---------------------------------------------------------------------------

(parameterList
  (typedIdentifier
    (identifier) @variable.parameter))

(objectBodyParameters
  (typedIdentifier
    (identifier) @variable.parameter))

; ---------------------------------------------------------------------------
; Properties (bat: base text)
; ---------------------------------------------------------------------------

(classProperty
  (identifier) @property)

(objectProperty
  (identifier) @property)

; ---------------------------------------------------------------------------
; Members and units
; ---------------------------------------------------------------------------

(qualifiedAccessExpr
  (identifier) @variable.member
  .)

(superAccessExpr
  (identifier) @variable.member
  .)

; duration / data-size units after a dot (bat: yellow)
((qualifiedAccessExpr
    (identifier) @type
    (#match? @type
      "^(ns|us|ms|s|min|h|d|b|kb|kib|mb|mib|gb|gib|tb|tib|pb|pib)$")))

; math constants: math.pi, math.e, math.minInt, ...
((qualifiedAccessExpr
    receiver: (unqualifiedAccessExpr
      (identifier) @_math)
    (identifier) @constant.builtin
    (#eq? @_math "math")
    (#match? @constant.builtin
      "^(minInt|minInt8|minInt16|minInt32|maxInt|maxInt8|maxInt16|maxInt32|maxUInt|maxUInt8|maxUInt16|maxUInt32|minFiniteFloat|maxFiniteFloat|minPositiveFloat|e|pi)$")))

; math functions: math.sqrt, math.sin, ...
((qualifiedAccessExpr
    receiver: (unqualifiedAccessExpr
      (identifier) @_math)
    (identifier) @function.call
    (#eq? @_math "math")
    (#match? @function.call
      "^(exp|sqrt|cbrt|log|log2|log10|sin|cos|tan|asin|acos|atan|gcd|lcm|isPowerOfTwo|min|max|atan2)$")))

; module / package namespace paths (bat: yellow)
(moduleClause
  (qualifiedIdentifier
    (identifier) @type))

; ---------------------------------------------------------------------------
; Annotations
; ---------------------------------------------------------------------------

(annotation
  (qualifiedIdentifier
    (identifier) @type))
