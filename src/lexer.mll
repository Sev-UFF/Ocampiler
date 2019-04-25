 (* File lexer.mll *)
        {
        open Parser        (* The type token is defined in parser.mli *)
        exception Eof
        }
        rule token = parse
            [' ' '\t' '\r' '\n' ]   { token lexbuf }     (* skip blanks *)
          | ['0'-'9']+ as  lxm      { NUMBER( int_of_string lxm) }
          | '+'                     { PLUS }
          | '-'                     { MINUS }
          | '*'                     { TIMES }
          | '/'                     { DIV }
          | '('                     { LPAREN }
          | ')'                     { RPAREN }
          | '<'                     { LESS }
          | '>'                     { GREATER }
          | ">="                    { GREATEREQUAL }
          | "<="                    { LESSEQUAL }
          | "True"  as lxm          { BOOLEAN(bool_of_string (String.lowercase_ascii lxm) )}
          | "False"   as lxm        { BOOLEAN(bool_of_string (String.lowercase_ascii lxm) ) }
          | "not"                   { NEGATION }
          | "and"                   { AND }
          | "or"                    { OR }
          | "=="                    { EQUALS }
          | "while"                 { LOOP }
          | "do"                    { DO }
          | "if"                    { IF }
          | "then"                  { THEN }
          | "else"                  { ELSE }
          | "end"                   { END }
          | eof                     { EOF }