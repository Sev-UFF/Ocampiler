open Pi;;


exception AutomatonException of string;;


type bindable = 
  | Loc of int
  | Value of int;;

  
type valueStackOptions = 
  | Int of int
  | Str of string
  | Bool of bool
  | LoopValue of command
  | CondValue of command
  | Assoc of string * bindable
  | Bind of bindable;;

and storable = 
  | Integer of int
  | Boolean of bool
  | Pointer of bindable

and bindable = 
  | Loc of int
  | IntConst of int
  | BoolConst of bool;;
