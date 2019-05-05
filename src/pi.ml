
  type arithmeticExpression = 
    | Num of int
    | Sum of expression * expression
    | Sub of expression * expression
    | Mul of expression * expression
    | Div of expression * expression 

  and booleanExpression =
    | Boo of bool  
    | Eq of expression * expression
    | Lt of expression * expression
    | Le of expression * expression
    | Gt of expression * expression
    | Ge of expression * expression
    | And of expression * expression
    | Or of expression * expression
    | Not of expression

  and expression = 
    | AExp of arithmeticExpression
    | BExp of booleanExpression
    | Id of string
  

  and command = 
    | Loop of booleanExpression * command
    | CSeq of command * command
    | Nop
    | Assign of expression * expression
    | Cond of booleanExpression * command * command


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

