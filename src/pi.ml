type expression = 
  | Num of int
  | Sum of expression * expression
  | Sub of expression * expression
  | Mul of expression * expression
  | Div of expression * expression
  | Ge of expression * expression
  | Gt of expression * expression
  | Le of expression * expression
  | Lt of expression * expression
  | Boo of bool
  | Not of expression;;



(* type expOptCode = SUM | SUB | MUL | DIV | EQ | LT | LE | GT | GE | AND | OR | NOT *)

