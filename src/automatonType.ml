open Pi;;


exception AutomatonException of string;;

type valueStackOptions = 
  | Int of int
  | Str of string
  | Bool of bool
  | LoopValue of command
  | CondValue of command;;

type storable = 
  | Integer of int
  | Boolean of bool;;

type bindable = 
  | Loc of int
  | Value of int;;

