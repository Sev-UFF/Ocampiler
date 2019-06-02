open Pi;;


exception AutomatonException of string;;

type valueStackOptions = 
  | Int of int
  | Str of string
  | Bool of bool
  | LoopValue of command
  | CondValue of command

and storable = 
  | Integer of int
  | Boolean of bool
  | Pointer of bindable

and bindable = 
  | Loc of int
  | IntConst of int
  | BoolConst of bool;;

