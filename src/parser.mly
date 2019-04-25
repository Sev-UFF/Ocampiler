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
        %type <Pi.booleanExpression> booleanExpression
        %%
        main:
            statement EOF                { $1 }
        ;
        statement:
          expression { Pi.Exp($1)}
        ;
        expression: 
            arithmeticExpression                    { Pi.AExp( $1) }
            | booleanExpression                     { Pi.BExp( $1) }
        ;
        arithmeticExpression:  
          NUMBER                                                    { Pi.Num($1) }
          | arithmeticExpression PLUS arithmeticExpression          { Pi.Sum( $1, $3 )  }
          | arithmeticExpression MINUS arithmeticExpression         { Pi.Sub( $1, $3 )  }
          | arithmeticExpression TIMES arithmeticExpression         { Pi.Mul( $1, $3 )  }
          | arithmeticExpression DIV arithmeticExpression           { Pi.Div( $1, $3 )  }
        ;
        booleanExpression:
          BOOLEAN { Pi.Boo($1) }
          | booleanExpression EQUALS booleanExpression                { Pi.Eq( Pi.BExp($1), Pi.BExp($3)) }
          | arithmeticExpression EQUALS arithmeticExpression          { Pi.Eq( Pi.AExp($1), Pi.AExp($3)) }
          | arithmeticExpression LESS arithmeticExpression            { Pi.Lt( $1, $3) }
          | arithmeticExpression LESSEQUAL arithmeticExpression       { Pi.Le( $1, $3) }
          | arithmeticExpression GREATER arithmeticExpression         { Pi.Gt( $1, $3) }
          | arithmeticExpression GREATEREQUAL arithmeticExpression    { Pi.Ge( $1, $3) }
          | booleanExpression AND booleanExpression                   { Pi.And( $1, $3) }
          | booleanExpression OR booleanExpression                    { Pi.Or( $1, $3) }
          | NEGATION booleanExpression                                     { Pi.Not( $2 )}
        ;