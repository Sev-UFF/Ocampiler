 /* File parser.mly */
        %token <int> NUMBER
        %token <bool> BOOLEAN
        %token <string> ID
        %token PLUS MINUS TIMES DIV
        %token LESS LESSEQUAL GREATER GREATEREQUAL EQUALS AND OR
        %token LOOP DO IF THEN ELSE END ASSIGN
        %token NEGATION NOP
        %token LPAREN RPAREN
        %token EOF 
        %left PLUS MINUS        /* lowest precedence */
        %left TIMES DIV         /* medium precedence */
        %start main             /* the entry point */
        %type <Pi.statement> main
        %type <Pi.statement> statement
        %type <Pi.expression> expression
        /* %type <Pi.declaration> declaration */
        %type <Pi.arithmeticExpression> arithmeticExpression
        %type <Pi.booleanExpression> booleanExpression
        %type <Pi.command> cmd
        %%
        main:
            statement EOF     { $1 }
        ;
        statement:
          expression { Pi.Exp($1)}
          | cmd      {Pi.Cmd($1)}
        ;
        cmd:
          LOOP booleanExpression DO cmd  END            { Pi.Loop($2, $4)}
          | IF booleanExpression THEN cmd ELSE cmd END  { Pi.Cond($2, $4, $6)}
          | IF booleanExpression THEN cmd END           { Pi.Cond($2, $4, Pi.Nop)}
          | ID ASSIGN expression                        { Pi.Assign(Pi.Id($1), $3) }
          | cmd  cmd                                    { Pi.CSeq($1, $2) }

        ;
        expression: 
            arithmeticExpression                    { Pi.AExp( $1) }
            | booleanExpression                     { Pi.BExp( $1) }
            | ID                                    { Pi.Id( $1) }
            | LPAREN expression RPAREN              { $2 }
        ;
        arithmeticExpression:  
          NUMBER                                              { Pi.Num($1) }
          | arithmeticExpression PLUS arithmeticExpression    { Pi.Sum(Pi.AExp($1), Pi.AExp($3) )  }
          | arithmeticExpression PLUS ID                      { Pi.Sum(Pi.AExp($1), Pi.Id($3) )  }
          | ID PLUS arithmeticExpression                      { Pi.Sum(Pi.Id($1), Pi.AExp($3) )  }
          | ID PLUS ID                                        { Pi.Sum(Pi.Id($1), Pi.Id($3) )  }
          | arithmeticExpression MINUS arithmeticExpression   { Pi.Sub(Pi.AExp($1), Pi.AExp($3) )  }
          | arithmeticExpression MINUS ID                     { Pi.Sub(Pi.AExp($1), Pi.Id($3) )  }
          | ID MINUS arithmeticExpression                     { Pi.Sub(Pi.Id($1), Pi.AExp($3) )  }
          | ID MINUS ID                                       { Pi.Sub(Pi.Id($1), Pi.Id($3) )  }
          | arithmeticExpression TIMES arithmeticExpression   { Pi.Mul(Pi.AExp($1), Pi.AExp($3) )  }
          | arithmeticExpression TIMES ID                     { Pi.Mul(Pi.AExp($1), Pi.Id($3) )  }
          | ID TIMES arithmeticExpression                     { Pi.Mul(Pi.Id($1), Pi.AExp($3) )  }
          | ID TIMES ID                                       { Pi.Mul(Pi.Id($1), Pi.Id($3) )  }
          | arithmeticExpression DIV arithmeticExpression     { Pi.Div(Pi.AExp($1), Pi.AExp($3) )  }
          | arithmeticExpression DIV ID                       { Pi.Div(Pi.AExp($1), Pi.Id($3) )  }
          | ID DIV arithmeticExpression                       { Pi.Div(Pi.Id($1), Pi.AExp($3) )  }
          | ID DIV ID                                         { Pi.Div(Pi.Id($1), Pi.Id($3) )  }
          | LPAREN arithmeticExpression RPAREN                { $2 }
        ;
        booleanExpression:
          BOOLEAN                                                     { Pi.Boo($1) }
          | booleanExpression EQUALS booleanExpression                { Pi.Eq( Pi.BExp($1), Pi.BExp($3)) }
          | booleanExpression EQUALS ID                               { Pi.Eq( Pi.BExp($1), Pi.Id($3)) }
          | ID EQUALS booleanExpression                               { Pi.Eq( Pi.Id($1), Pi.BExp($3)) }
          | ID EQUALS ID                                              { Pi.Eq( Pi.Id($1), Pi.Id($3)) }
          | arithmeticExpression EQUALS arithmeticExpression          { Pi.Eq( Pi.AExp($1), Pi.AExp($3)) }
          | arithmeticExpression EQUALS ID                            { Pi.Eq( Pi.AExp($1), Pi.Id($3)) }
          | ID EQUALS arithmeticExpression                            { Pi.Eq( Pi.Id($1), Pi.AExp($3)) }
          | ID EQUALS ID                                              { Pi.Eq( Pi.Id($1), Pi.Id($3)) }
          | arithmeticExpression LESS arithmeticExpression            { Pi.Lt( (Pi.AExp($1), Pi.AExp($3))) }
          | arithmeticExpression LESS ID                              { Pi.Lt( (Pi.AExp($1), Pi.Id($3))) }
          | ID LESS arithmeticExpression                              { Pi.Lt( (Pi.Id($1), Pi.AExp($3))) }
          | ID LESS ID                                                { Pi.Lt( (Pi.Id($1), Pi.Id($3))) }
          | arithmeticExpression LESSEQUAL arithmeticExpression       { Pi.Le( Pi.AExp($1), Pi.AExp($3)) }
          | arithmeticExpression LESSEQUAL ID                         { Pi.Lt( (Pi.AExp($1), Pi.Id($3))) }
          | ID LESSEQUAL arithmeticExpression                         { Pi.Lt( (Pi.Id($1), Pi.AExp($3))) }
          | ID LESSEQUAL ID                                           { Pi.Lt( (Pi.Id($1), Pi.Id($3))) }
          | arithmeticExpression GREATER arithmeticExpression         { Pi.Gt( Pi.AExp($1), Pi.AExp($3)) }
          | arithmeticExpression GREATER ID                           { Pi.Lt( (Pi.AExp($1), Pi.Id($3))) }
          | ID GREATER arithmeticExpression                           { Pi.Lt( (Pi.Id($1), Pi.AExp($3))) }
          | ID GREATER ID                                             { Pi.Lt( (Pi.Id($1), Pi.Id($3))) }
          | arithmeticExpression GREATEREQUAL arithmeticExpression    { Pi.Ge( (Pi.AExp($1), Pi.AExp($3))) }
          | arithmeticExpression GREATEREQUAL ID                      { Pi.Lt( (Pi.AExp($1), Pi.Id($3))) }
          | ID GREATEREQUAL arithmeticExpression                      { Pi.Lt( (Pi.Id($1), Pi.AExp($3))) }
          | ID GREATEREQUAL ID                                        { Pi.Lt( (Pi.Id($1), Pi.Id($3))) }
          | booleanExpression AND booleanExpression                   { Pi.And( Pi.BExp($1), Pi.BExp($3)) }
          | booleanExpression AND ID                                  { Pi.Lt( (Pi.BExp($1), Pi.Id($3))) }
          | ID AND booleanExpression                                  { Pi.Lt( (Pi.Id($1), Pi.BExp($3))) }
          | ID AND ID                                                 { Pi.Lt( (Pi.Id($1), Pi.Id($3))) }
          | booleanExpression OR booleanExpression                    { Pi.Or( Pi.BExp($1), Pi.BExp($3)) }
          | booleanExpression OR ID                                   { Pi.Lt( (Pi.BExp($1), Pi.Id($3))) }
          | ID OR booleanExpression                                   { Pi.Lt( (Pi.Id($1), Pi.BExp($3))) }
          | ID OR ID                                                  { Pi.Lt( (Pi.Id($1), Pi.Id($3))) }
          | NEGATION LPAREN booleanExpression RPAREN                  { Pi.Not( Pi.BExp($3) )}
          | NEGATION LPAREN ID RPAREN                                 { Pi.Not( Pi.Id($3) )}
          | LPAREN booleanExpression RPAREN                           { $2 }
;