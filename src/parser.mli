type token =
  | NUMBER of (int)
  | BOOLEAN of (bool)
  | PLUS
  | MINUS
  | TIMES
  | DIV
  | LESS
  | LESSEQUAL
  | GREATER
  | GREATEREQUAL
  | EQUALS
  | AND
  | OR
  | LOOP
  | DO
  | IF
  | THEN
  | ELSE
  | END
  | NEGATION
  | NOP
  | LPAREN
  | RPAREN
  | EOF

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Pi.statement
