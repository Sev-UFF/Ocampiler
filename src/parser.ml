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
  | NOT
  | LOOP
  | DO
  | IF
  | THEN
  | ELSE
  | END
  | NEGATION
  | LPAREN
  | RPAREN
  | EOF

open Parsing;;
let _ = parse_error;;
let yytransl_const = [|
  259 (* PLUS *);
  260 (* MINUS *);
  261 (* TIMES *);
  262 (* DIV *);
  263 (* LESS *);
  264 (* LESSEQUAL *);
  265 (* GREATER *);
  266 (* GREATEREQUAL *);
  267 (* EQUALS *);
  268 (* AND *);
  269 (* OR *);
  270 (* NOT *);
  271 (* LOOP *);
  272 (* DO *);
  273 (* IF *);
  274 (* THEN *);
  275 (* ELSE *);
  276 (* END *);
  277 (* NEGATION *);
  278 (* LPAREN *);
  279 (* RPAREN *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  257 (* NUMBER *);
  258 (* BOOLEAN *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\006\000\006\000\006\000\003\000\003\000\
\003\000\004\000\004\000\004\000\004\000\004\000\004\000\005\000\
\005\000\005\000\005\000\005\000\005\000\005\000\005\000\005\000\
\005\000\005\000\000\000"

let yylen = "\002\000\
\002\000\001\000\001\000\004\000\006\000\004\000\001\000\001\000\
\003\000\001\000\003\000\003\000\003\000\003\000\003\000\001\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\002\000\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\010\000\016\000\000\000\000\000\000\000\000\000\
\027\000\000\000\002\000\000\000\000\000\003\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\001\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\009\000\
\015\000\026\000\000\000\000\000\000\000\013\000\014\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\004\000\
\000\000\000\000\000\000\005\000"

let yydgoto = "\002\000\
\009\000\010\000\011\000\016\000\013\000\014\000"

let yysindex = "\255\255\
\005\255\000\000\000\000\000\000\007\255\007\255\007\255\014\255\
\000\000\010\000\000\000\086\255\052\255\000\000\007\255\086\255\
\052\255\036\255\088\255\002\255\075\255\043\255\000\000\013\255\
\013\255\013\255\013\255\013\255\013\255\013\255\013\255\013\255\
\007\255\007\255\007\255\075\255\043\255\252\254\252\254\000\000\
\000\000\000\000\013\255\102\255\102\255\000\000\000\000\099\255\
\099\255\099\255\099\255\099\255\052\255\052\255\052\255\000\000\
\022\255\034\255\252\254\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\033\000\043\000\000\000\000\000\000\000\
\017\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\001\000\018\000\000\000\000\000\026\000\
\034\000\042\000\050\000\058\000\059\000\062\000\068\000\000\000\
\051\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\037\000\045\000\253\255\241\255"

let yytablesize = 347
let yytable = "\001\000\
\011\000\017\000\018\000\019\000\022\000\003\000\004\000\003\000\
\004\000\023\000\006\000\037\000\007\000\003\000\003\000\004\000\
\025\000\012\000\005\000\006\000\005\000\007\000\056\000\057\000\
\040\000\019\000\008\000\005\000\015\000\053\000\054\000\055\000\
\007\000\020\000\043\000\008\000\024\000\025\000\026\000\027\000\
\059\000\021\000\008\000\060\000\020\000\012\000\033\000\034\000\
\035\000\022\000\006\000\038\000\021\000\033\000\034\000\035\000\
\041\000\018\000\017\000\036\000\000\000\023\000\033\000\034\000\
\035\000\042\000\000\000\024\000\044\000\045\000\046\000\047\000\
\048\000\049\000\050\000\051\000\052\000\024\000\025\000\026\000\
\027\000\028\000\029\000\030\000\031\000\032\000\000\000\058\000\
\024\000\025\000\026\000\027\000\028\000\029\000\030\000\031\000\
\032\000\041\000\033\000\034\000\035\000\024\000\025\000\026\000\
\027\000\039\000\026\000\027\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\011\000\011\000\000\000\000\000\011\000\
\011\000\011\000\011\000\011\000\011\000\011\000\000\000\000\000\
\011\000\000\000\011\000\000\000\012\000\012\000\000\000\011\000\
\012\000\012\000\012\000\012\000\012\000\012\000\012\000\000\000\
\025\000\012\000\025\000\012\000\019\000\019\000\019\000\025\000\
\012\000\019\000\000\000\019\000\020\000\020\000\020\000\000\000\
\019\000\020\000\000\000\020\000\021\000\021\000\021\000\000\000\
\020\000\021\000\000\000\021\000\022\000\022\000\022\000\000\000\
\021\000\022\000\000\000\022\000\018\000\018\000\018\000\000\000\
\022\000\018\000\017\000\018\000\017\000\023\000\000\000\023\000\
\018\000\017\000\000\000\024\000\023\000\024\000\000\000\000\000\
\000\000\000\000\024\000"

let yycheck = "\001\000\
\000\000\005\000\006\000\007\000\008\000\001\001\002\001\001\001\
\002\001\000\000\015\001\015\000\017\001\001\001\001\001\002\001\
\000\000\000\000\014\001\015\001\014\001\017\001\038\000\039\000\
\023\001\000\000\022\001\014\001\022\001\033\000\034\000\035\000\
\000\000\000\000\022\001\022\001\003\001\004\001\005\001\006\001\
\019\001\000\000\000\000\059\000\008\000\001\000\011\001\012\001\
\013\001\000\000\000\000\016\001\008\000\011\001\012\001\013\001\
\023\001\000\000\000\000\015\000\255\255\000\000\011\001\012\001\
\013\001\023\001\255\255\000\000\024\000\025\000\026\000\027\000\
\028\000\029\000\030\000\031\000\032\000\003\001\004\001\005\001\
\006\001\007\001\008\001\009\001\010\001\011\001\255\255\043\000\
\003\001\004\001\005\001\006\001\007\001\008\001\009\001\010\001\
\011\001\023\001\011\001\012\001\013\001\003\001\004\001\005\001\
\006\001\018\001\005\001\006\001\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\003\001\004\001\255\255\255\255\007\001\
\008\001\009\001\010\001\011\001\012\001\013\001\255\255\255\255\
\016\001\255\255\018\001\255\255\003\001\004\001\255\255\023\001\
\007\001\008\001\009\001\010\001\011\001\012\001\013\001\255\255\
\016\001\016\001\018\001\018\001\011\001\012\001\013\001\023\001\
\023\001\016\001\255\255\018\001\011\001\012\001\013\001\255\255\
\023\001\016\001\255\255\018\001\011\001\012\001\013\001\255\255\
\023\001\016\001\255\255\018\001\011\001\012\001\013\001\255\255\
\023\001\016\001\255\255\018\001\011\001\012\001\013\001\255\255\
\023\001\016\001\016\001\018\001\018\001\016\001\255\255\018\001\
\023\001\023\001\255\255\016\001\023\001\018\001\255\255\255\255\
\255\255\255\255\023\001"

let yynames_const = "\
  PLUS\000\
  MINUS\000\
  TIMES\000\
  DIV\000\
  LESS\000\
  LESSEQUAL\000\
  GREATER\000\
  GREATEREQUAL\000\
  EQUALS\000\
  AND\000\
  OR\000\
  NOT\000\
  LOOP\000\
  DO\000\
  IF\000\
  THEN\000\
  ELSE\000\
  END\000\
  NEGATION\000\
  LPAREN\000\
  RPAREN\000\
  EOF\000\
  "

let yynames_block = "\
  NUMBER\000\
  BOOLEAN\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Pi.statement) in
    Obj.repr(
# 21 "parser.mly"
                                         ( _1 )
# 238 "parser.ml"
               : Pi.statement))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Pi.expression) in
    Obj.repr(
# 25 "parser.mly"
                     ( Pi.Exp(_1))
# 245 "parser.ml"
               : Pi.statement))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Pi.cmd) in
    Obj.repr(
# 26 "parser.mly"
                (Pi.Cmd(_1))
# 252 "parser.ml"
               : Pi.statement))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : Pi.booleanExpression) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : Pi.cmd) in
    Obj.repr(
# 29 "parser.mly"
                                                    ( Pi.Loop(_2, _4))
# 260 "parser.ml"
               : Pi.cmd))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : Pi.booleanExpression) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : Pi.cmd) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : Pi.cmd) in
    Obj.repr(
# 30 "parser.mly"
                                                    ( Pi.Cond(_2, _4, _6))
# 269 "parser.ml"
               : Pi.cmd))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : Pi.booleanExpression) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : Pi.cmd) in
    Obj.repr(
# 31 "parser.mly"
                                                    ( Pi.Cond(_2, _4, Pi.Nop))
# 277 "parser.ml"
               : Pi.cmd))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 34 "parser.mly"
                                                    ( Pi.AExp( _1) )
# 284 "parser.ml"
               : Pi.expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Pi.booleanExpression) in
    Obj.repr(
# 35 "parser.mly"
                                                    ( Pi.BExp( _1) )
# 291 "parser.ml"
               : Pi.expression))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Pi.expression) in
    Obj.repr(
# 36 "parser.mly"
                                                    ( _2 )
# 298 "parser.ml"
               : Pi.expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 39 "parser.mly"
                                                                    ( Pi.Num(_1) )
# 305 "parser.ml"
               : Pi.arithmeticExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.arithmeticExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 40 "parser.mly"
                                                                    ( Pi.Sum( _1, _3 )  )
# 313 "parser.ml"
               : Pi.arithmeticExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.arithmeticExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 41 "parser.mly"
                                                                    ( Pi.Sub( _1, _3 )  )
# 321 "parser.ml"
               : Pi.arithmeticExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.arithmeticExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 42 "parser.mly"
                                                                    ( Pi.Mul( _1, _3 )  )
# 329 "parser.ml"
               : Pi.arithmeticExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.arithmeticExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 43 "parser.mly"
                                                                    ( Pi.Div( _1, _3 )  )
# 337 "parser.ml"
               : Pi.arithmeticExpression))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Pi.arithmeticExpression) in
    Obj.repr(
# 44 "parser.mly"
                                                                    ( _2 )
# 344 "parser.ml"
               : Pi.arithmeticExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : bool) in
    Obj.repr(
# 47 "parser.mly"
                  ( Pi.Boo(_1) )
# 351 "parser.ml"
               : Pi.booleanExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.booleanExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.booleanExpression) in
    Obj.repr(
# 48 "parser.mly"
                                                                      ( Pi.Eq( Pi.BExp(_1), Pi.BExp(_3)) )
# 359 "parser.ml"
               : Pi.booleanExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.arithmeticExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 49 "parser.mly"
                                                                      ( Pi.Eq( Pi.AExp(_1), Pi.AExp(_3)) )
# 367 "parser.ml"
               : Pi.booleanExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.arithmeticExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 50 "parser.mly"
                                                                      ( Pi.Lt( _1, _3) )
# 375 "parser.ml"
               : Pi.booleanExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.arithmeticExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 51 "parser.mly"
                                                                      ( Pi.Le( _1, _3) )
# 383 "parser.ml"
               : Pi.booleanExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.arithmeticExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 52 "parser.mly"
                                                                      ( Pi.Gt( _1, _3) )
# 391 "parser.ml"
               : Pi.booleanExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.arithmeticExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 53 "parser.mly"
                                                                      ( Pi.Ge( _1, _3) )
# 399 "parser.ml"
               : Pi.booleanExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.booleanExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.booleanExpression) in
    Obj.repr(
# 54 "parser.mly"
                                                                      ( Pi.And( _1, _3) )
# 407 "parser.ml"
               : Pi.booleanExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.booleanExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.booleanExpression) in
    Obj.repr(
# 55 "parser.mly"
                                                                      ( Pi.Or( _1, _3) )
# 415 "parser.ml"
               : Pi.booleanExpression))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Pi.booleanExpression) in
    Obj.repr(
# 56 "parser.mly"
                                                                      ( Pi.Not( _2 ))
# 422 "parser.ml"
               : Pi.booleanExpression))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Pi.booleanExpression) in
    Obj.repr(
# 57 "parser.mly"
                                                                      ( _2 )
# 429 "parser.ml"
               : Pi.booleanExpression))
(* Entry main *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Pi.statement)
