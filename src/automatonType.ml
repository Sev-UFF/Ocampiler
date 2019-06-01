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

type storable = 
  | Integer of int
  | Boolean of bool;;

