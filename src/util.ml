open Pi;;

(* Definindo pilha *)
class ['t] stack init = object
  val mutable items : 't list = init

  method pop = 
    match items with
    | hd :: tl -> 
      items <- tl;
      Some hd
    | [] -> None

  method push hd =
    items <- hd :: items
  
end;;

let readInputFile file_name =
  let ch = open_in file_name in
    let s = really_input_string ch (in_channel_length ch) in
    close_in ch;
    s

let rec string_of_expression expression = 
  match expression with 
  | Sum (x, y) -> "SUM (" ^ (string_of_expression x) ^ ", " ^ (string_of_expression y) ^ ")"
  | Sub (x, y) -> "SUB (" ^ (string_of_expression x) ^ ", " ^ (string_of_expression y) ^ ")"
  | Num x -> "NUM (" ^ (string_of_int x) ^ ")"
  | Mul (x, y) -> "MUL (" ^ (string_of_expression x) ^ ", " ^ (string_of_expression y) ^ ")"
  | Div (x, y) -> "DIV (" ^ (string_of_expression x) ^ ", " ^ (string_of_expression y) ^ ")"