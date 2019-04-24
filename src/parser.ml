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
  270 (* NEGATION *);
  271 (* LPAREN *);
  272 (* RPAREN *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  257 (* NUMBER *);
  258 (* BOOLEAN *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\003\000\004\000\004\000\000\000"

let yylen = "\002\000\
\002\000\001\000\001\000\001\000\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\004\000\006\000\000\000\002\000\000\000\001\000\
\000\000\005\000"

let yydgoto = "\002\000\
\004\000\005\000\006\000\007\000"

let yysindex = "\255\255\
\000\255\000\000\000\000\000\000\002\000\000\000\001\255\000\000\
\000\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\003\000\000\000\
\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\000\000\252\255"

let yytablesize = 5
let yytable = "\001\000\
\003\000\008\000\003\000\009\000\010\000"

let yycheck = "\001\000\
\001\001\000\000\000\000\003\001\009\000"

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
# 18 "parser.mly"
                                         ( _1 )
# 107 "parser.ml"
               : Pi.statement))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Pi.expression) in
    Obj.repr(
# 21 "parser.mly"
                     ( Pi.Exp(_1))
# 114 "parser.ml"
               : Pi.statement))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 24 "parser.mly"
                                                   ( Pi.AExp( _1) )
# 121 "parser.ml"
               : Pi.expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 27 "parser.mly"
                                   ( Pi.Num(_1) )
# 128 "parser.ml"
               : Pi.arithmeticExpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Pi.arithmeticExpression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Pi.arithmeticExpression) in
    Obj.repr(
# 28 "parser.mly"
                                                                    ( Pi.Sum( _1, _3 )  )
# 136 "parser.ml"
               : Pi.arithmeticExpression))
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
