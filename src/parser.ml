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
  271 (* NEGATION *);
  272 (* LPAREN *);
  273 (* RPAREN *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  257 (* NUMBER *);
  258 (* BOOLEAN *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\003\000\003\000\004\000\004\000\004\000\004\000\
\004\000\005\000\005\000\005\000\005\000\005\000\005\000\005\000\
\005\000\005\000\005\000\000\000"

let yylen = "\002\000\
\002\000\001\000\001\000\001\000\001\000\003\000\003\000\003\000\
\003\000\001\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\005\000\010\000\000\000\020\000\000\000\002\000\
\000\000\000\000\000\000\000\000\001\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\008\000\009\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000"

let yydgoto = "\002\000\
\006\000\007\000\008\000\011\000\010\000"

let yysindex = "\255\255\
\002\255\000\000\000\000\000\000\002\255\000\000\002\000\000\000\
\040\255\041\255\040\255\041\255\000\000\004\255\004\255\004\255\
\004\255\004\255\004\255\004\255\004\255\004\255\002\255\002\255\
\002\255\005\255\005\255\000\000\000\000\003\255\003\255\003\255\
\003\255\003\255\041\255\041\255\041\255"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\013\000\014\000\000\000\019\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\001\000\012\000\000\000\000\000\015\000\018\000\021\000\
\024\000\027\000\020\000\023\000\025\000"

let yygindex = "\000\000\
\000\000\000\000\000\000\016\000\017\000"

let yytablesize = 296
let yytable = "\001\000\
\006\000\013\000\003\000\004\000\003\000\014\000\015\000\016\000\
\017\000\016\000\017\000\007\000\003\000\004\000\013\000\005\000\
\009\000\014\000\019\000\011\000\015\000\012\000\017\000\016\000\
\018\000\000\000\012\000\000\000\000\000\026\000\027\000\028\000\
\029\000\030\000\031\000\032\000\033\000\034\000\000\000\035\000\
\036\000\037\000\014\000\015\000\016\000\017\000\018\000\019\000\
\020\000\021\000\022\000\023\000\024\000\025\000\000\000\000\000\
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
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\006\000\006\000\000\000\000\000\006\000\
\006\000\006\000\006\000\006\000\006\000\006\000\007\000\007\000\
\000\000\000\000\007\000\007\000\007\000\007\000\007\000\007\000\
\007\000\013\000\013\000\013\000\014\000\014\000\014\000\015\000\
\015\000\015\000\016\000\016\000\016\000\012\000\012\000\012\000"

let yycheck = "\001\000\
\000\000\000\000\001\001\002\001\001\001\003\001\004\001\005\001\
\006\001\005\001\006\001\000\000\000\000\000\000\000\000\014\001\
\001\000\000\000\000\000\000\000\000\000\005\000\000\000\000\000\
\000\000\255\255\000\000\255\255\255\255\014\000\015\000\016\000\
\017\000\018\000\019\000\020\000\021\000\022\000\255\255\023\000\
\024\000\025\000\003\001\004\001\005\001\006\001\007\001\008\001\
\009\001\010\001\011\001\011\001\012\001\013\001\255\255\255\255\
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
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\003\001\004\001\255\255\255\255\007\001\
\008\001\009\001\010\001\011\001\012\001\013\001\003\001\004\001\
\255\255\255\255\007\001\008\001\009\001\010\001\011\001\012\001\
\013\001\011\001\012\001\013\001\011\001\012\001\013\001\011\001\
\012\001\013\001\011\001\012\001\013\001\011\001\012\001\013\001"

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
# 19 "parser.mly"
                                         ( _1 )
# 195 "parser.ml"
               : Pi.statement))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Pi.expression) in
    Obj.repr(
# 22 "parser.mly"
                     ( Pi.Exp(_1))
# 202 "parser.ml"
               : Pi.statement))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 25 "parser.mly"
                                                    ( Pi.AExp( _1) )
# 209 "parser.ml"
               : Pi.expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Pi.booleanExpression) in
    Obj.repr(
# 26 "parser.mly"
                                                    ( Pi.BExp( _1) )
# 216 "parser.ml"
               : Pi.expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 29 "parser.mly"
                                                                    ( Pi.Num(_1) )
# 223 "parser.ml"
               : Pi.arithmeticExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.arithmeticExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 30 "parser.mly"
                                                                    ( Pi.Sum( _1, _3 )  )
# 231 "parser.ml"
               : Pi.arithmeticExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.arithmeticExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 31 "parser.mly"
                                                                    ( Pi.Sub( _1, _3 )  )
# 239 "parser.ml"
               : Pi.arithmeticExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.arithmeticExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 32 "parser.mly"
                                                                    ( Pi.Mul( _1, _3 )  )
# 247 "parser.ml"
               : Pi.arithmeticExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.arithmeticExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 33 "parser.mly"
                                                                    ( Pi.Div( _1, _3 )  )
# 255 "parser.ml"
               : Pi.arithmeticExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : bool) in
    Obj.repr(
# 36 "parser.mly"
                  ( Pi.Boo(_1) )
# 262 "parser.ml"
               : Pi.booleanExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.booleanExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.booleanExpression) in
    Obj.repr(
# 37 "parser.mly"
                                                                      ( Pi.Eq( Pi.BExp(_1), Pi.BExp(_3)) )
# 270 "parser.ml"
               : Pi.booleanExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.arithmeticExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 38 "parser.mly"
                                                                      ( Pi.Eq( Pi.AExp(_1), Pi.AExp(_3)) )
# 278 "parser.ml"
               : Pi.booleanExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.arithmeticExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 39 "parser.mly"
                                                                      ( Pi.Lt( _1, _3) )
# 286 "parser.ml"
               : Pi.booleanExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.arithmeticExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 40 "parser.mly"
                                                                      ( Pi.Le( _1, _3) )
# 294 "parser.ml"
               : Pi.booleanExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.arithmeticExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 41 "parser.mly"
                                                                      ( Pi.Gt( _1, _3) )
# 302 "parser.ml"
               : Pi.booleanExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.arithmeticExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 42 "parser.mly"
                                                                      ( Pi.Ge( _1, _3) )
# 310 "parser.ml"
               : Pi.booleanExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.booleanExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.booleanExpression) in
    Obj.repr(
# 43 "parser.mly"
                                                                      ( Pi.And( _1, _3) )
# 318 "parser.ml"
               : Pi.booleanExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.booleanExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.booleanExpression) in
    Obj.repr(
# 44 "parser.mly"
                                                                      ( Pi.Or( _1, _3) )
# 326 "parser.ml"
               : Pi.booleanExpression))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Pi.booleanExpression) in
    Obj.repr(
# 45 "parser.mly"
                                                                      ( Pi.Not( _2 ))
# 333 "parser.ml"
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
