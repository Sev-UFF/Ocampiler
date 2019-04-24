
  type arithmeticExpression = 
    | Num of int
    | Sum of arithmeticExpression * arithmeticExpression
    | Sub of arithmeticExpression * arithmeticExpression
    | Mul of arithmeticExpression * arithmeticExpression
    | Div of arithmeticExpression * arithmeticExpression;;

  type booleanExpression =
    | Boo of bool  
    | Eq of booleanExpression * booleanExpression
    (* | Eq of arithmeticExpression * arithmeticExpression *)
    | Lt of arithmeticExpression * arithmeticExpression
    | Le of arithmeticExpression * arithmeticExpression
    | Gt of arithmeticExpression * arithmeticExpression
    | Ge of arithmeticExpression * arithmeticExpression
    | And of booleanExpression * booleanExpression
    | Or of booleanExpression * booleanExpression
    | Not of booleanExpression;;

  type expression = 
    | AExp of arithmeticExpression
    | BExp of booleanExpression;;

  type statement = 
  | Exp of expression;;

(* type expOptCode = SUM | SUB | MUL | DIV | EQ | LT | LE | GT | GE | AND | OR | NOT *)

