  /* File parser.mly */
        %token <float> VALUE
        %token PLUS MINUS TIMES DIV
        %token LPAREN RPAREN
        %token EOF
        %left PLUS MINUS        /* lowest precedence */
        %left TIMES DIV         /* medium precedence */
        %nonassoc UMINUS        /* highest precedence */
        %start main             /* the entry point */
        %type <Pi.statement> main
        %%
        main:
            expr EOF                { $1 }
        ;
        expr: 
            VALUE                     { new Pi.num  $1 }
          | LPAREN expr RPAREN      { new Pi.statement }
          | expr PLUS expr          {  new Pi.statement }
          | expr MINUS expr         { new Pi.statement }
          | expr TIMES expr         { new Pi.statement }
          | expr DIV expr           { new Pi.statement }
          | MINUS expr %prec UMINUS { new Pi.statement }
        ;