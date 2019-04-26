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

open Parsing;;
let _ = parse_error;;
let yytransl_const = [|
  260 (* PLUS *);
  261 (* MINUS *);
  262 (* TIMES *);
  263 (* DIV *);
  264 (* LESS *);
  265 (* LESSEQUAL *);
  266 (* GREATER *);
  267 (* GREATEREQUAL *);
  268 (* EQUALS *);
  269 (* AND *);
  270 (* OR *);
  271 (* LOOP *);
  272 (* DO *);
  273 (* IF *);
  274 (* THEN *);
  275 (* ELSE *);
  276 (* END *);
  277 (* ASSIGN *);
  278 (* NEGATION *);
  279 (* NOP *);
  280 (* LPAREN *);
  281 (* RPAREN *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  257 (* NUMBER *);
  258 (* BOOLEAN *);
  259 (* ID *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\006\000\006\000\006\000\006\000\006\000\
\003\000\003\000\003\000\004\000\004\000\004\000\004\000\004\000\
\004\000\005\000\005\000\005\000\005\000\005\000\005\000\005\000\
\005\000\005\000\005\000\005\000\000\000"

let yylen = "\002\000\
\002\000\001\000\001\000\005\000\007\000\005\000\003\000\002\000\
\001\000\001\000\003\000\001\000\003\000\003\000\003\000\003\000\
\003\000\001\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\004\000\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\012\000\018\000\000\000\000\000\000\000\000\000\
\000\000\029\000\000\000\002\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\001\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\007\000\000\000\
\000\000\000\000\000\000\000\000\011\000\017\000\028\000\000\000\
\000\000\000\000\015\000\016\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\027\000\000\000\
\004\000\000\000\006\000\000\000\005\000"

let yydgoto = "\002\000\
\010\000\011\000\012\000\018\000\014\000\038\000"

let yysindex = "\005\000\
\006\255\000\000\000\000\000\000\245\254\014\255\014\255\244\254\
\023\255\000\000\014\000\000\000\125\255\130\255\071\255\023\255\
\014\255\125\255\081\255\127\255\014\255\251\254\095\255\036\255\
\000\000\003\255\003\255\003\255\003\255\003\255\003\255\003\255\
\003\255\003\255\014\255\014\255\014\255\071\255\000\000\095\255\
\036\255\071\255\071\255\103\255\000\000\000\000\000\000\003\255\
\028\255\028\255\000\000\000\000\117\255\117\255\117\255\117\255\
\117\255\130\255\130\255\130\255\043\255\037\255\000\000\064\255\
\000\000\071\255\000\000\093\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\044\000\062\000\026\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\022\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\001\000\019\000\000\000\000\000\037\000\055\000\073\000\091\000\
\109\000\127\000\138\000\156\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\002\000\050\000\252\255\255\255"

let yytablesize = 437
let yytable = "\015\000\
\013\000\019\000\020\000\003\000\024\000\001\000\003\000\004\000\
\005\000\016\000\022\000\021\000\041\000\025\000\003\000\004\000\
\044\000\039\000\014\000\045\000\006\000\008\000\007\000\003\000\
\004\000\003\000\048\000\008\000\000\000\009\000\058\000\059\000\
\060\000\028\000\029\000\008\000\021\000\017\000\000\000\005\000\
\061\000\062\000\000\000\009\000\008\000\005\000\009\000\035\000\
\036\000\037\000\013\000\006\000\000\000\007\000\022\000\066\000\
\067\000\006\000\023\000\007\000\047\000\010\000\065\000\000\000\
\068\000\013\000\040\000\026\000\027\000\028\000\029\000\000\000\
\023\000\005\000\000\000\049\000\050\000\051\000\052\000\053\000\
\054\000\055\000\056\000\057\000\000\000\006\000\000\000\007\000\
\046\000\000\000\024\000\000\000\035\000\036\000\037\000\005\000\
\042\000\064\000\026\000\027\000\028\000\029\000\030\000\031\000\
\032\000\033\000\034\000\006\000\020\000\007\000\000\000\000\000\
\069\000\000\000\035\000\036\000\037\000\000\000\000\000\046\000\
\026\000\027\000\028\000\029\000\000\000\000\000\019\000\063\000\
\026\000\027\000\028\000\029\000\030\000\031\000\032\000\033\000\
\034\000\025\000\035\000\036\000\037\000\035\000\036\000\037\000\
\043\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\026\000\000\000\000\000\000\000\000\000\
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
\000\000\000\000\000\000\013\000\013\000\013\000\000\000\000\000\
\013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
\013\000\013\000\013\000\013\000\013\000\014\000\014\000\014\000\
\000\000\013\000\014\000\014\000\014\000\014\000\014\000\014\000\
\014\000\014\000\014\000\014\000\014\000\014\000\014\000\021\000\
\008\000\008\000\000\000\014\000\000\000\000\000\009\000\000\000\
\021\000\021\000\021\000\021\000\021\000\021\000\021\000\021\000\
\021\000\022\000\009\000\000\000\009\000\021\000\009\000\009\000\
\010\000\000\000\022\000\022\000\022\000\022\000\022\000\022\000\
\022\000\022\000\022\000\023\000\010\000\000\000\010\000\022\000\
\010\000\010\000\000\000\000\000\023\000\023\000\023\000\023\000\
\023\000\023\000\023\000\023\000\023\000\024\000\000\000\000\000\
\000\000\023\000\000\000\000\000\000\000\000\000\024\000\024\000\
\024\000\024\000\024\000\024\000\024\000\024\000\024\000\020\000\
\000\000\000\000\000\000\024\000\000\000\000\000\000\000\000\000\
\020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
\020\000\019\000\000\000\000\000\000\000\020\000\000\000\000\000\
\000\000\000\000\000\000\000\000\025\000\019\000\019\000\019\000\
\019\000\019\000\019\000\000\000\000\000\000\000\000\000\019\000\
\025\000\025\000\025\000\025\000\025\000\025\000\026\000\000\000\
\000\000\000\000\025\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\026\000\026\000\026\000\026\000\026\000\026\000\
\000\000\000\000\000\000\000\000\026\000"

let yycheck = "\001\000\
\000\000\006\000\007\000\001\001\009\000\001\000\001\001\002\001\
\003\001\021\001\009\000\024\001\017\000\000\000\001\001\002\001\
\021\000\016\000\000\000\025\001\015\001\000\000\017\001\001\001\
\002\001\000\000\024\001\022\001\255\255\024\001\035\000\036\000\
\037\000\006\001\007\001\022\001\000\000\024\001\255\255\003\001\
\042\000\043\000\255\255\000\000\022\001\003\001\024\001\012\001\
\013\001\014\001\001\000\015\001\255\255\017\001\000\000\019\001\
\020\001\015\001\009\000\017\001\025\001\000\000\020\001\255\255\
\066\000\016\000\017\000\004\001\005\001\006\001\007\001\255\255\
\000\000\003\001\255\255\026\000\027\000\028\000\029\000\030\000\
\031\000\032\000\033\000\034\000\255\255\015\001\255\255\017\001\
\025\001\255\255\000\000\255\255\012\001\013\001\014\001\003\001\
\016\001\048\000\004\001\005\001\006\001\007\001\008\001\009\001\
\010\001\011\001\012\001\015\001\000\000\017\001\255\255\255\255\
\020\001\255\255\012\001\013\001\014\001\255\255\255\255\025\001\
\004\001\005\001\006\001\007\001\255\255\255\255\000\000\025\001\
\004\001\005\001\006\001\007\001\008\001\009\001\010\001\011\001\
\012\001\000\000\012\001\013\001\014\001\012\001\013\001\014\001\
\018\001\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\000\000\255\255\255\255\255\255\255\255\
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
\255\255\255\255\255\255\003\001\004\001\005\001\255\255\255\255\
\008\001\009\001\010\001\011\001\012\001\013\001\014\001\015\001\
\016\001\017\001\018\001\019\001\020\001\003\001\004\001\005\001\
\255\255\025\001\008\001\009\001\010\001\011\001\012\001\013\001\
\014\001\015\001\016\001\017\001\018\001\019\001\020\001\003\001\
\019\001\020\001\255\255\025\001\255\255\255\255\003\001\255\255\
\012\001\013\001\014\001\015\001\016\001\017\001\018\001\019\001\
\020\001\003\001\015\001\255\255\017\001\025\001\019\001\020\001\
\003\001\255\255\012\001\013\001\014\001\015\001\016\001\017\001\
\018\001\019\001\020\001\003\001\015\001\255\255\017\001\025\001\
\019\001\020\001\255\255\255\255\012\001\013\001\014\001\015\001\
\016\001\017\001\018\001\019\001\020\001\003\001\255\255\255\255\
\255\255\025\001\255\255\255\255\255\255\255\255\012\001\013\001\
\014\001\015\001\016\001\017\001\018\001\019\001\020\001\003\001\
\255\255\255\255\255\255\025\001\255\255\255\255\255\255\255\255\
\012\001\013\001\014\001\015\001\016\001\017\001\018\001\019\001\
\020\001\003\001\255\255\255\255\255\255\025\001\255\255\255\255\
\255\255\255\255\255\255\255\255\003\001\015\001\016\001\017\001\
\018\001\019\001\020\001\255\255\255\255\255\255\255\255\025\001\
\015\001\016\001\017\001\018\001\019\001\020\001\003\001\255\255\
\255\255\255\255\025\001\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\015\001\016\001\017\001\018\001\019\001\020\001\
\255\255\255\255\255\255\255\255\025\001"

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
  LOOP\000\
  DO\000\
  IF\000\
  THEN\000\
  ELSE\000\
  END\000\
  ASSIGN\000\
  NEGATION\000\
  NOP\000\
  LPAREN\000\
  RPAREN\000\
  EOF\000\
  "

let yynames_block = "\
  NUMBER\000\
  BOOLEAN\000\
  ID\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Pi.statement) in
    Obj.repr(
# 22 "parser.mly"
                                         ( _1 )
# 269 "parser.ml"
               : Pi.statement))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Pi.expression) in
    Obj.repr(
# 25 "parser.mly"
                     ( Pi.Exp(_1))
# 276 "parser.ml"
               : Pi.statement))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Pi.cmd) in
    Obj.repr(
# 26 "parser.mly"
                (Pi.Cmd(_1))
# 283 "parser.ml"
               : Pi.statement))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : Pi.booleanExpression) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : Pi.cmd) in
    Obj.repr(
# 29 "parser.mly"
                                                       ( Pi.Loop(_2, _4))
# 291 "parser.ml"
               : Pi.cmd))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 5 : Pi.booleanExpression) in
    let _4 = (Parsing.peek_val __caml_parser_env 3 : Pi.cmd) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : Pi.cmd) in
    Obj.repr(
# 30 "parser.mly"
                                                        ( Pi.Cond(_2, _4, _6))
# 300 "parser.ml"
               : Pi.cmd))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : Pi.booleanExpression) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : Pi.cmd) in
    Obj.repr(
# 31 "parser.mly"
                                                     ( Pi.Cond(_2, _4, Pi.Nop))
# 308 "parser.ml"
               : Pi.cmd))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.expression) in
    Obj.repr(
# 32 "parser.mly"
                                                    ( Pi.Assign(_1, _3) )
# 316 "parser.ml"
               : Pi.cmd))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Pi.cmd) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Pi.cmd) in
    Obj.repr(
# 33 "parser.mly"
                                                 ( Pi.CSeq(_1, _2) )
# 324 "parser.ml"
               : Pi.cmd))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 37 "parser.mly"
                                                    ( Pi.AExp( _1) )
# 331 "parser.ml"
               : Pi.expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Pi.booleanExpression) in
    Obj.repr(
# 38 "parser.mly"
                                                    ( Pi.BExp( _1) )
# 338 "parser.ml"
               : Pi.expression))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Pi.expression) in
    Obj.repr(
# 39 "parser.mly"
                                                    ( _2 )
# 345 "parser.ml"
               : Pi.expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 42 "parser.mly"
                                                                    ( Pi.Num(_1) )
# 352 "parser.ml"
               : Pi.arithmeticExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.arithmeticExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 43 "parser.mly"
                                                                    ( Pi.Sum( _1, _3 )  )
# 360 "parser.ml"
               : Pi.arithmeticExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.arithmeticExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 44 "parser.mly"
                                                                    ( Pi.Sub( _1, _3 )  )
# 368 "parser.ml"
               : Pi.arithmeticExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.arithmeticExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 45 "parser.mly"
                                                                    ( Pi.Mul( _1, _3 )  )
# 376 "parser.ml"
               : Pi.arithmeticExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.arithmeticExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 46 "parser.mly"
                                                                    ( Pi.Div( _1, _3 )  )
# 384 "parser.ml"
               : Pi.arithmeticExpression))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Pi.arithmeticExpression) in
    Obj.repr(
# 47 "parser.mly"
                                                                    ( _2 )
# 391 "parser.ml"
               : Pi.arithmeticExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : bool) in
    Obj.repr(
# 50 "parser.mly"
                  ( Pi.Boo(_1) )
# 398 "parser.ml"
               : Pi.booleanExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.booleanExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.booleanExpression) in
    Obj.repr(
# 51 "parser.mly"
                                                                      ( Pi.Eq( Pi.BExp(_1), Pi.BExp(_3)) )
# 406 "parser.ml"
               : Pi.booleanExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.arithmeticExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 52 "parser.mly"
                                                                      ( Pi.Eq( Pi.AExp(_1), Pi.AExp(_3)) )
# 414 "parser.ml"
               : Pi.booleanExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.arithmeticExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 53 "parser.mly"
                                                                      ( Pi.Lt( _1, _3) )
# 422 "parser.ml"
               : Pi.booleanExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.arithmeticExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 54 "parser.mly"
                                                                      ( Pi.Le( _1, _3) )
# 430 "parser.ml"
               : Pi.booleanExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.arithmeticExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 55 "parser.mly"
                                                                      ( Pi.Gt( _1, _3) )
# 438 "parser.ml"
               : Pi.booleanExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.arithmeticExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 56 "parser.mly"
                                                                      ( Pi.Ge( _1, _3) )
# 446 "parser.ml"
               : Pi.booleanExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.booleanExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.booleanExpression) in
    Obj.repr(
# 57 "parser.mly"
                                                                      ( Pi.And( _1, _3) )
# 454 "parser.ml"
               : Pi.booleanExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.booleanExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.booleanExpression) in
    Obj.repr(
# 58 "parser.mly"
                                                                      ( Pi.Or( _1, _3) )
# 462 "parser.ml"
               : Pi.booleanExpression))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : Pi.booleanExpression) in
    Obj.repr(
# 59 "parser.mly"
                                                                                       ( Pi.Not( _3 ))
# 469 "parser.ml"
               : Pi.booleanExpression))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Pi.booleanExpression) in
    Obj.repr(
# 60 "parser.mly"
                                                                      ( _2 )
# 476 "parser.ml"
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
