
  type arithmeticExpression = 
    | Num of int
    | Sum of arithmeticExpression * arithmeticExpression
    | Sub of arithmeticExpression * arithmeticExpression
    | Mul of arithmeticExpression * arithmeticExpression
    | Div of arithmeticExpression * arithmeticExpression 

  and booleanExpression =
    | Boo of bool  
    | Eq of expression * expression
    | Lt of arithmeticExpression * arithmeticExpression
    | Le of arithmeticExpression * arithmeticExpression
    | Gt of arithmeticExpression * arithmeticExpression
    | Ge of arithmeticExpression * arithmeticExpression
    | And of booleanExpression * booleanExpression
    | Or of booleanExpression * booleanExpression
    | Not of booleanExpression

  and expression = 
    | AExp of arithmeticExpression
    | BExp of booleanExpression

  and statement = 
  | Exp of expression
  
  and expOc =
  | OPSUM
  | OPMUL

  and pi = 
  | Statement of statement
  | ExpOc of expOc;;

(* type expOptCode = SUM | SUB | MUL | DIV | EQ | LT | LE | GT | GE | AND | OR | NOT *)

