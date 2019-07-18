 /* File parser.mly */
        %token <int> NUMBER
        %token <bool> BOOLEAN
        %token <string> ID
        %token PLUS MINUS TIMESORPOINTER DIV
        %token LESS LESSEQUAL GREATER GREATEREQUAL EQUALS AND OR
        %token LOOP DO IF THEN ELSE END ASSIGN LET VAR CNS BIND IN COMMA ADDRESS POINTER FUNCTION CALL REC
        %token NEGATION NOP
        %token LPAREN RPAREN 
        %token EOF 
        %left PLUS MINUS        /* lowest precedence */
        %left TIMESORPOINTER DIV         /* medium precedence */
        %start main             /* the entry point */
        %type <Pi.statement> main
        %type <Pi.statement> statement
        %type <Pi.expression> expression
        %type <Pi.declaration> declaration
        %type <Pi.arithmeticExpression> arithmeticExpression
        %type <Pi.booleanExpression> booleanExpression
        %type <Pi.command> command
        %type <Pi.expression> bindableVariable
        %type <Pi.expression> variable
        %type <Pi.abstraction> abstraction
        %type <(Pi.expression list)> actuals
        %type <(Pi.expression list)> formals
        %%
        main:
            statement EOF     { $1 }
        ;
        statement:
            expression   { Pi.Exp($1)}
          | command      { Pi.Cmd($1)}
        ;
        declaration:
          | VAR ID BIND expression            { Pi.Bind(Pi.Id($2), Pi.Ref($4)) }
          | CNS ID BIND bindableVariable      { Pi.Bind(Pi.Id($2), $4) }
          | declaration COMMA declaration     { Pi.DSeq($1, $3) }
          | FUNCTION ID abstraction           { Pi.BindAbs(Pi.Id($2), $3) }
          | REC FUNCTION ID abstraction       { Pi.Rbnd(Pi.Id($3), $4) }
          | LPAREN declaration RPAREN         { $2 }
        ;
        abstraction:
           LPAREN formals RPAREN BIND command    { Pi.AbsFunction($2, $5) }
          | LPAREN  RPAREN BIND command          { Pi.AbsFunction([], $4) }
          | LPAREN abstraction RPAREN            { $2 }
        ;
        command:
          LOOP expression DO command  END                 { Pi.Loop(($2), $4)}
          | IF expression THEN command ELSE command END   { Pi.Cond(($2), $4, $6)}
          | IF expression THEN command END                { Pi.Cond(($2), $4, Pi.Nop)}
          | ID ASSIGN expression                          { Pi.Assign(Pi.Id($1), $3) }
          | command  command                              { Pi.CSeq($1, $2) }
          | LET declaration IN command                    { Pi.Blk($2, $4)}
          | LET declaration IN command END                { Pi.Blk($2, $4)}
          | ID LPAREN actuals RPAREN                      { Pi.Call(Pi.Id($1), $3) }
          | ID LPAREN  RPAREN                             { Pi.Call(Pi.Id($1), []) }
          | LPAREN command RPAREN                         { $2 }
        ;
        actuals:
           actuals COMMA expression     { ($1@[$3]) }
          | expression                  { [$1] }
        ;
        formals:
           ID COMMA formals             { [Pi.Id($1)]@$3 }
          | ID                          { [ Pi.Id($1) ] }
        ;
        expression: 
          ADDRESS ID                    { Pi.DeRef(Pi.Id($2))}
          | bindableVariable            { $1 }
          | LPAREN expression RPAREN    { $2 }     
        ;   
        bindableVariable: 
            arithmeticExpression              { Pi.AExp( $1) }
          | booleanExpression                 { Pi.BExp( $1) }
          | variable                          { $1 }
          | LPAREN bindableVariable RPAREN    { $2 }
        ;
        variable:
            ID                        { Pi.Id( $1) }
          | TIMESORPOINTER ID         { Pi.ValRef(Pi.Id($2))}
          | LPAREN variable RPAREN    { $2 }
        ;
        arithmeticExpression:  
          NUMBER                                                     { Pi.Num($1) }
          | arithmeticExpression PLUS arithmeticExpression           { Pi.Sum(Pi.AExp($1), Pi.AExp($3) )  }
          | arithmeticExpression PLUS variable                       { Pi.Sum(Pi.AExp($1), $3 )  }
          | variable PLUS arithmeticExpression                       { Pi.Sum($1, Pi.AExp($3) )  }
          | variable PLUS variable                                   { Pi.Sum($1, $3 )  }
          | arithmeticExpression MINUS arithmeticExpression          { Pi.Sub(Pi.AExp($1), Pi.AExp($3) )  }
          | arithmeticExpression MINUS variable                      { Pi.Sub(Pi.AExp($1), $3 )  }
          | variable MINUS arithmeticExpression                      { Pi.Sub($1, Pi.AExp($3) )  }
          | variable MINUS variable                                  { Pi.Sub($1, $3 )  }
          | arithmeticExpression TIMESORPOINTER arithmeticExpression { Pi.Mul(Pi.AExp($1), Pi.AExp($3) )  }
          | arithmeticExpression TIMESORPOINTER variable             { Pi.Mul(Pi.AExp($1),$3 )  }
          | variable TIMESORPOINTER arithmeticExpression             { Pi.Mul($1, Pi.AExp($3) )  }
          | variable TIMESORPOINTER variable                         { Pi.Mul($1, $3 )  }
          | arithmeticExpression DIV arithmeticExpression            { Pi.Div(Pi.AExp($1), Pi.AExp($3) )  }
          | arithmeticExpression DIV variable                        { Pi.Div(Pi.AExp($1), $3 )  }
          | variable DIV arithmeticExpression                        { Pi.Div($1, Pi.AExp($3) )  }
          | variable DIV variable                                    { Pi.Div($1, $3 )  }
          | LPAREN arithmeticExpression RPAREN                       { $2 }      
        ;
        booleanExpression:
          BOOLEAN                                                    { Pi.Boo($1) }
          | booleanExpression EQUALS booleanExpression               { Pi.Eq( Pi.BExp($1), Pi.BExp($3)) }
          | booleanExpression EQUALS variable                        { Pi.Eq( Pi.BExp($1), $3) }
          | variable EQUALS booleanExpression                        { Pi.Eq( $1, Pi.BExp($3)) }
          | variable EQUALS variable                                 { Pi.Eq( $1, $3) }
          | arithmeticExpression EQUALS arithmeticExpression         { Pi.Eq( Pi.AExp($1), Pi.AExp($3)) }
          | arithmeticExpression EQUALS variable                     { Pi.Eq( Pi.AExp($1), $3) }
          | variable EQUALS arithmeticExpression                     { Pi.Eq( $1, Pi.AExp($3)) }
          | arithmeticExpression LESS arithmeticExpression           { Pi.Lt( (Pi.AExp($1), Pi.AExp($3))) }
          | arithmeticExpression LESS variable                       { Pi.Lt( (Pi.AExp($1), $3)) }
          | variable LESS arithmeticExpression                       { Pi.Lt( ($1, Pi.AExp($3))) }
          | variable LESS variable                                   { Pi.Lt( ($1, $3)) }
          | arithmeticExpression LESSEQUAL arithmeticExpression      { Pi.Le( Pi.AExp($1), Pi.AExp($3)) }
          | arithmeticExpression LESSEQUAL variable                  { Pi.Le( (Pi.AExp($1), $3)) }
          | variable LESSEQUAL arithmeticExpression                  { Pi.Le( ($1, Pi.AExp($3))) }
          | variable LESSEQUAL variable                              { Pi.Le( ($1, $3)) }
          | arithmeticExpression GREATER arithmeticExpression        { Pi.Gt( Pi.AExp($1), Pi.AExp($3)) }
          | arithmeticExpression GREATER variable                    { Pi.Gt( (Pi.AExp($1), $3)) }
          | variable GREATER arithmeticExpression                    { Pi.Gt( ($1, Pi.AExp($3))) }
          | variable GREATER variable                                { Pi.Gt( ($1, $3)) }
          | arithmeticExpression GREATEREQUAL arithmeticExpression   { Pi.Ge( (Pi.AExp($1), Pi.AExp($3))) }
          | arithmeticExpression GREATEREQUAL variable               { Pi.Ge( (Pi.AExp($1), $3)) }
          | variable GREATEREQUAL arithmeticExpression               { Pi.Ge( ($1, Pi.AExp($3))) }
          | variable GREATEREQUAL variable                           { Pi.Ge( ($1, $3)) }
          | booleanExpression AND booleanExpression                  { Pi.And( Pi.BExp($1), Pi.BExp($3)) }
          | booleanExpression AND variable                           { Pi.And( (Pi.BExp($1), $3)) }
          | variable AND booleanExpression                           { Pi.And( ($1, Pi.BExp($3))) }
          | variable AND variable                                    { Pi.And( ($1, $3)) }
          | booleanExpression OR booleanExpression                   { Pi.Or( Pi.BExp($1), Pi.BExp($3)) }
          | booleanExpression OR variable                            { Pi.Or( (Pi.BExp($1), $3)) }
          | variable OR booleanExpression                            { Pi.Or( ($1, Pi.BExp($3))) }
          | variable OR variable                                     { Pi.Or( ($1, $3)) }
          | NEGATION LPAREN booleanExpression RPAREN                 { Pi.Not( Pi.BExp($3) )}
          | NEGATION LPAREN variable RPAREN                          { Pi.Not( $3 )}
          | LPAREN booleanExpression RPAREN                          { $2 }
          
;