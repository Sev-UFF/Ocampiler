open Pi;;


exception AutomatonException of string;;

  
type valueStackOptions = 
  | Int of int
  | Str of string
  | Bool of bool
  | LoopValue of command
  | CondValue of command
  | Bind of loc
  | Locations of int list
  | Env of (string, bindable) Hashtbl.t
  

and storable = 
  | Integer of int
  | Boolean of bool
  | Pointer of loc


and bindable = 
  | Loc of loc
  | IntConst of int
  | BoolConst of bool
  
and loc =
  | Location of int;;
