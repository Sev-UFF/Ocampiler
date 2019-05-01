
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
  

  and command = 
    | Loop of booleanExpression * command
    | CSeq of command * command
    | Nop
    | Assign of id * expression
    | Cond of booleanExpression * command * command

  and id = string

  and statement = 
   | Exp of expression
   | Cmd of command
  
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

   and cmdOc =
   | OPASSIGN 
   | OPLOOP 
   | OPCOND


  and control = 
  | Statement of statement
  | ExpOc of expOc
  | CmdOc of cmdOc;;

