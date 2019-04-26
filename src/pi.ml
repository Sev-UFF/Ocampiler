
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

  and cmd = 
    | Loop of booleanExpression * cmd
    | CSeq of cmd * cmd
    | Nop
    | Assign of string * expression
    | Cond of booleanExpression * cmd * cmd

  and statement = 
   | Exp of expression
   | Cmd of cmd
  
  and expOc =
   | OPSUM
   | OPMUL
   | OPSUB 
   | OPDIV 
   | OPEQ 
   | OPLT 
   | OPLE 
   | OPGT 
   | OPGE 
   | OPAND 
   | OPOR 
   | OPNOT
   | OPASSIGN 
   | OPLOOP 
   | OPCOND
   | OPNOP
   | OPCSEQ

  and pi = 
  | Statement of statement
  | ExpOc of expOc;;

(* type expOptCode = SUM | SUB | MUL | DIV | EQ | LT | LE | GT | GE | AND | OR | NOT *)

