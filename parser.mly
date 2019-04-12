  /* File parser.mly */
        %token <string> INT
        %token PLUS MINUS TIMES DIV
        %token LPAREN RPAREN
        %token EOL
        %left PLUS MINUS        /* lowest precedence */
        %left TIMES DIV         /* medium precedence */
        %nonassoc UMINUS        /* highest precedence */
        %start main             /* the entry point */
        %type <expression> main
        %%
        main:
            expr EOL                { $1 }
        ;
        expr:
            INT                     {  pi.num $1 }
          | LPAREN expr RPAREN      { $2 }
          | expr PLUS expr          {  Sum(1, 2)  "SUM(" ^  $1 ^ ", " ^  $3 ^ ")"}
          | expr MINUS expr         { "$1 - $3" }
          | expr TIMES expr         { "$1 * $3" }
          | expr DIV expr           { "$1 / $3" }
          | MINUS expr %prec UMINUS { "- $2" }
        ;