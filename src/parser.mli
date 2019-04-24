type token =
  | VALUE of (int)
  | PLUS
  | MINUS
  | TIMES
  | DIV
  | LESS
  | LESSEQUAL
  | GREATER
  | GREATEREQUAL
  | EQUAL
  | NEGATION
  | TRUE
  | FALSE
  | LPAREN
  | RPAREN
  | EOF

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Pi.expression
