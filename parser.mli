type token =
  | INT of (string)
  | PLUS
  | MINUS
  | TIMES
  | DIV
  | LPAREN
  | RPAREN
  | EOL

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> string
