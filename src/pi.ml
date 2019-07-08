
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

  and command = 
    | Loop of expression * command
    | CSeq of command * command
    | Nop
    | Assign of expression * expression
    | Cond of expression * command * command
    | Blk of declaration * command
    | Call of expression * expression list (* Call(<Id>, <Exp>* ) *)

  and declaration = 
    | DSeq of declaration * declaration
    | Bind of expression * expression   (* Bind(<Id>, <Exp>) *)
    | BindAbs of expression * statement (* Bind(<Id>, <Abs>) *)

  and abstraction = 
   | AbsFunction of expression list * command  (* Abs(<Id*>, <Blk>)  *)
 
  and statement = 
   | Exp of expression
   | Cmd of command
   | Dec of declaration
   | Abs of abstraction
  
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
   | OPCALL of expression * int

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

