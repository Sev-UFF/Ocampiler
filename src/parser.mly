  /* File parser.mly */
        %token <int> NUMBER
        %token <bool> BOOLEAN
        %token PLUS MINUS TIMES DIV
        %token LESS LESSEQUAL GREATER GREATEREQUAL EQUALS AND OR
        %token NEGATION
        %token LPAREN RPAREN
        %token EOF
        %left PLUS MINUS        /* lowest precedence */
        %left TIMES DIV         /* medium precedence */
        %start main             /* the entry point */
        %type <Pi.statement> main
        %type <Pi.statement> statement
        %type <Pi.expression> expression
        %type <Pi.arithmeticExpression> arithmeticExpression
        %%
        main:
            statement EOF                { $1 }
        ;
        statement:
          expression { Pi.Exp($1)}
        ;
        expression: 
            arithmeticExpression                   { Pi.AExp( $1) }
        ;
        arithmeticExpression:  
          NUMBER                   { Pi.Num($1) }
          | arithmeticExpression PLUS arithmeticExpression          { Pi.Sum( $1, $3 )  }
        ;