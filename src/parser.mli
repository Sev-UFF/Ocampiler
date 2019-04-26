type token =
  | NUMBER of (int)
  | BOOLEAN of (bool)
  | ID of (string)
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
  | ASSIGN
  | NEGATION
  | NOP
  | LPAREN
  | RPAREN
  | EOF
  | EOL

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Pi.statement
