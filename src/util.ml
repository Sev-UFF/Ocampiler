open Pi;;
open AutomatonType;;


(* Files *)
let readInputFile file_name =
  let ch = open_in file_name in
    let s = really_input_string ch (in_channel_length ch) in
    close_in ch;
    s;;

(* Pi Denotations *)
let rec string_of_arithmetic_expression arithmetic_expression = 
  match arithmetic_expression with 
  | Sum (x, y) -> "SUM (" ^ (string_of_expression x) ^ ", " ^ (string_of_expression y) ^ ")"
  | Num (x) -> "NUM (" ^ (string_of_int x) ^ ")"
  | Sub (x, y) -> "SUB (" ^ (string_of_expression x) ^ ", " ^ (string_of_expression y) ^ ")"
  | Div (x, y) -> "DIV (" ^ (string_of_expression x) ^ ", " ^ (string_of_expression y) ^ ")"
  | Mul (x, y) -> "MUL (" ^ (string_of_expression x) ^ ", " ^ (string_of_expression y) ^ ")"
  
and string_of_boolean_expression boolean_expression =
  match boolean_expression with 
  | Boo(x) -> "BOO (" ^ (string_of_bool x) ^ ")"
  | Eq (x, y) ->  "EQ (" ^ (string_of_expression x) ^ ", " ^ (string_of_expression y) ^ ")"
  | Lt (x, y) ->  "LT (" ^ (string_of_expression x) ^ ", " ^ (string_of_expression y) ^ ")"
  | Le (x, y) ->  "LE (" ^ (string_of_expression x) ^ ", " ^ (string_of_expression y) ^ ")"
  | Gt (x, y) ->  "GT (" ^ (string_of_expression x) ^ ", " ^ (string_of_expression y) ^ ")"
  | Ge (x, y) ->  "GE (" ^ (string_of_expression x) ^ ", " ^ (string_of_expression y) ^ ")"
  | And (x, y) ->  "AND (" ^ (string_of_expression x) ^ ", " ^ (string_of_expression y) ^ ")"
  | Or (x, y) ->  "OR (" ^ (string_of_expression x) ^ ", " ^ (string_of_expression y) ^ ")"
  | Not (x) ->  "NOT (" ^ (string_of_expression x) ^ ")"


and string_of_expression expression =
  match expression with
  | AExp(x) -> string_of_arithmetic_expression x
  | BExp(x) -> string_of_boolean_expression x
  | Id(x) -> "ID (" ^ x ^ ")"
  | Ref(x) -> "REF (" ^ (string_of_expression x) ^ ")"
  | DeRef(x) -> "DEREF (" ^ (string_of_expression x) ^ ")"
  | ValRef(x) -> "VALREF (" ^ (string_of_expression x) ^ ")"

and string_of_command command = 
  match command with
  | Loop(x, y) -> "LOOP (" ^ (string_of_expression x) ^ ", " ^ (string_of_command y) ^ ")"
  | CSeq(x, y) -> "CSEQ (" ^ (string_of_command x) ^ ", " ^ (string_of_command y) ^ ")"
  | Nop -> "NOP"
  | Assign(x, y) -> "ASSIGN (" ^ (string_of_expression x) ^ ", " ^ (string_of_expression y) ^ ")"
  | Cond(x, y, z) -> "COND (" ^ (string_of_expression x) ^ ", " ^ (string_of_command y) ^ ", " ^ (string_of_command z) ^ ")"
  | Blk(x, y) -> "BLK (" ^ (string_of_declaration x) ^ ", " ^ (string_of_command y) ^ ")"

and string_of_declaration declaration =
  match declaration with
  | Bind(x, y) -> "BIND (" ^ (string_of_expression x) ^ ", " ^ (string_of_expression y) ^ ")"
  | DSeq(x, y) -> "DSEQ (" ^ (string_of_declaration x) ^ ", " ^ (string_of_declaration y) ^ ")"

and string_of_statement statement =
  match statement with
  | Exp (x) -> string_of_expression x
  | Cmd (x) -> string_of_command x
  | Dec(x) -> string_of_declaration x
  
and string_of_exp_opcode expOc =
  match expOc with
  | OPSUM -> "#SUM"
  | OPMUL -> "#MUL"
  | OPSUB  -> "#SUB"
  | OPDIV  -> "#DIV"
  | OPEQ  -> "#EQ"
  | OPLT  -> "#LT"
  | OPLE  -> "#LE"
  | OPGT  -> "#GT"
  | OPGE  -> "#GE"
  | OPAND  -> "#AND"
  | OPOR  -> "#OR"
  | OPNOT -> "#NOT"

  and string_of_cmd_opcode cmdOc =
  match cmdOc with
  | OPASSIGN  -> "#ASSIGN"
  | OPLOOP  -> "#LOOP"
  | OPCOND -> "#COND"

  and string_dec_opcode decOc = 
  match decOc with
  | OPREF -> "#REF"
  | OPBLKDEC -> "#BLKDEC"
  | OPBLKCMD -> "#BLKCMD"
  | OPBIND -> "#BIND"

and string_of_control ctn =
  match ctn with 
  | Statement(x) -> string_of_statement x
  | ExpOc(x) -> string_of_exp_opcode x
  | CmdOc(x) -> string_of_cmd_opcode x 
  | DecOc(x) -> string_dec_opcode x
;;
  
(* Stacks *)
let string_of_stack stack func = 
  "[ " ^ (String.concat ", " (List.map func (List.of_seq (Stack.to_seq stack))) ) ^ " ]"
;;


(* Dictionaries *)
let string_of_dictionary dict func =
  "{\n " ^ (String.concat ",\n" (List.map func (List.of_seq (Hashtbl.to_seq dict))) ) ^ "\n }"
;;


(* Automaton *)
let string_of_value_stack item =
  match item with
  | Int(x) -> string_of_int x
  | Str(x) -> x
  | Bool(x) -> if x then "True" else "False"
  | LoopValue (x) -> (string_of_command x)
  | CondValue (x) -> (string_of_command x);;

let string_of_bindable bindable =
  match bindable with
  | Loc(x) -> "LOC [" ^ (string_of_int x) ^ "]"
  | Value(x) -> "VALUE (" ^ (string_of_int x) ^ ")";;

let string_of_storable storable =
  match storable with
  | Integer(x) ->  (string_of_int x) 
  | Boolean(x) -> if x then "True" else "False";;

let string_of_storable_dictionary (key, value) =
  "\t( [" ^ (string_of_int key) ^ "]: " ^ (string_of_storable value) ^ " )";;

let string_of_bindable_dictionary (key, value) =
   "\t( " ^ key ^ ": " ^ (string_of_bindable value) ^ " )";;


let string_of_stacks controlStack valueStack = 
  "Pilha de Controle:\n" ^  (string_of_stack controlStack string_of_control) ^ "\nPilha de Valor:\n" ^ (string_of_stack valueStack string_of_value_stack);;

let string_of_dictionaries environment memory = 
  "Ambiente:\n" ^ (string_of_dictionary environment string_of_bindable_dictionary) ^ "\nMemória:\n" ^ (string_of_dictionary memory string_of_storable_dictionary);;

let string_of_iteration controlStack valueStack environment memory =
  (* "Estado #" ^ (string_of_int(!steps)) ^ " do π autômato\n" ^  *)
  (string_of_stacks controlStack valueStack) ^ "\n" ^ (string_of_dictionaries environment memory) ^ "\n------------------------------------------------------------------------------------------------------------\n";;


(* Lists *)
let printStackTraceItem index (controlStack, valueStack, environment, memory) =
  print_endline ("Estado #" ^ (string_of_int(index)) ^ " do π autômato\n\n" ^ (string_of_iteration controlStack valueStack environment memory));;