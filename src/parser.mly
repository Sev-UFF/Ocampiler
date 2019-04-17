  /* File parser.mly */
        %token <int> VALUE
        %token PLUS MINUS TIMES DIV
        %token LPAREN RPAREN
        %token EOF
        %left PLUS MINUS        /* lowest precedence */
        %left TIMES DIV         /* medium precedence */
        %nonassoc UMINUS        /* highest precedence */
        %start main             /* the entry point */
        %type <Pi.expression> main
        %%
        main:
            expr EOF                { $1 }
        ;
        expr: 
            VALUE                     { Pi.Num($1) }
          | LPAREN expr RPAREN      { $2 }
          | expr PLUS expr          {  Pi.Sum($1, $3)  }
          | expr MINUS expr         { Pi.Num(2) }
          | expr TIMES expr         { Pi.Num(2) }
          | expr DIV expr           { Pi.Num(2) }
          | MINUS expr %prec UMINUS { Pi.Num(2) }
        ;