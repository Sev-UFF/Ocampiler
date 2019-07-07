
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
    | Ref of expression
    | DeRef of expression
    | ValRef of expression
    | Formal of expression list
    | Actual of expression list
    | Parametro of expression list

  and command = 
    | Loop of expression * command
    | CSeq of command * command
    | Nop
    | Assign of expression * expression
    | Cond of expression * command * command
    | Blk of declaration * command
    | Call of expression * expression

  (*and abstraction = 
    | Abs of expression * command
*)
  and declaration = 
    | DSeq of declaration * declaration
    | Bind of expression * expression 
    | BindAbs of expression * statement
 
  and statement = 
   | Exp of expression
   | Cmd of command
   | Dec of declaration
   | Abs of expression * command
  
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

   and decOC =
   | OPREF
   | OPBLKDEC
   | OPBLKCMD
   | OPBIND

  and control = 
  | Statement of statement
  | ExpOc of expOc
  | CmdOc of cmdOc
  | DecOc of decOC;;

