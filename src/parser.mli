type token =
  | NUMBER of (int)
  | BOOLEAN of (bool)
  | ID of (string)
  | PLUS
  | MINUS
  | TIMESORPOINTER
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
  | LET
  | VAR
  | CNS
  | BIND
  | IN
  | COMMA
  | ADDRESS
  | POINTER
  | NEGATION
  | NOP
  | LPAREN
  | RPAREN
  | EOF

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Pi.statement
