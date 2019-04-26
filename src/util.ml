open Pi;;

(* Definindo pilha *)
class  stack init = object
  val mutable items : pi list = init

  method pop = 
    match items with
    | hd :: tl -> 
      items <- tl;
       hd;
    | [] -> None

  method push hd =
    items <- hd :: items
  
end;;

let readInputFile file_name =
  let ch = open_in file_name in
    let s = really_input_string ch (in_channel_length ch) in
    close_in ch;
    s



let rec string_of_arithmetic_expression arithmetic_expression = 
  match arithmetic_expression with 
  | Sum (x, y) -> "SUM (" ^ (string_of_arithmetic_expression x) ^ ", " ^ (string_of_arithmetic_expression y) ^ ")"
  | Num (x) -> "NUM (" ^ (string_of_int x) ^ ")"
  | Sub (x, y) -> "SUB (" ^ (string_of_arithmetic_expression x) ^ ", " ^ (string_of_arithmetic_expression y) ^ ")"
  | Div (x, y) -> "DIV (" ^ (string_of_arithmetic_expression x) ^ ", " ^ (string_of_arithmetic_expression y) ^ ")"
  | Mul (x, y) -> "MUL (" ^ (string_of_arithmetic_expression x) ^ ", " ^ (string_of_arithmetic_expression y) ^ ")"
  
and string_of_boolean_expression boolean_expression =
  match boolean_expression with 
  | Boo(x) -> "BOO (" ^ (string_of_bool x) ^ ")"
  | Eq (x, y) ->  "EQ (" ^ (string_of_expression x) ^ ", " ^ (string_of_expression y) ^ ")"
  | Lt (x, y) ->  "LT (" ^ (string_of_arithmetic_expression x) ^ ", " ^ (string_of_arithmetic_expression y) ^ ")"
  | Le (x, y) ->  "LE (" ^ (string_of_arithmetic_expression x) ^ ", " ^ (string_of_arithmetic_expression y) ^ ")"
  | Gt (x, y) ->  "GT (" ^ (string_of_arithmetic_expression x) ^ ", " ^ (string_of_arithmetic_expression y) ^ ")"
  | Ge (x, y) ->  "GE (" ^ (string_of_arithmetic_expression x) ^ ", " ^ (string_of_arithmetic_expression y) ^ ")"
  | And (x, y) ->  "AND (" ^ (string_of_boolean_expression x) ^ ", " ^ (string_of_boolean_expression y) ^ ")"
  | Or (x, y) ->  "OR (" ^ (string_of_boolean_expression x) ^ ", " ^ (string_of_boolean_expression y) ^ ")"
  | Not (x) ->  "NOT (" ^ (string_of_boolean_expression x) ^ ")"


and string_of_expression expression =
  match expression with
  | AExp(x) -> string_of_arithmetic_expression x
  | BExp(x) -> string_of_boolean_expression x

and string_of_command command = 
  match command with
  | Loop(x, y) -> "LOOP (" ^ (string_of_boolean_expression x) ^ ", " ^ (string_of_command y) ^ ")"
  | CSeq(x, y) -> "CSEQ (" ^ (string_of_command x) ^ ", " ^ (string_of_command y) ^ ")"
  | Nop -> "NOP"
  | Assign(x, y) -> "ASSIGN ( ID(" ^  x ^ "), " ^ (string_of_expression y) ^ ")"
  | Cond(x, y, z) -> "COND (" ^ (string_of_boolean_expression x) ^ ", " ^ (string_of_command y) ^ ", " ^ (string_of_command z) ^ ")"

and string_of_statement statement =
  match statement with
  | Exp (x) -> string_of_expression x
  | Cmd (x) -> string_of_command x
  
and string_of_pi pi = "tteste";;