open Util;;
open Pi;;

exception AutomatonException of string;;

type valueStackOptions = 
  | Int of int
  | Str of string
  | Bool of bool;;

type storable = 
  | Integer of int
  | Boolean of bool;;

type bindable = 
  | Loc of int
  | Value of int;;

let string_of_value_stack item =
  match item with
  | Int(x) -> string_of_int x
  | Str(x) -> x
  | Bool(x) -> if x then "True" else "False";;

let string_of_bindable bindable =
  match bindable with
  | Loc(x) -> "LOC (" ^ (string_of_int x) ^ ")"
  | Value(x) -> "VALUE (" ^ (string_of_int x) ^ ")";;

let string_of_storable storable =
  match storable with
  | Integer(x) ->  (string_of_int x) 
  | Boolean(x) -> if x then "True" else "False";;

let string_of_storable_dictionary key value =
  print_string ("( " ^ (string_of_int key) ^ ": " ^ (string_of_storable value) ^ " )")

let string_of_bindable_dictionary key value =
  print_string ("( " ^ key ^ ": " ^ (string_of_bindable value) ^ " )")

let rec evaluatePi controlStack valueStack environment memory = 
  if not(Stack.is_empty controlStack) then begin

    print_endline "Pilha de Controle:";
    print_endline (string_of_stack controlStack string_of_ctn);
    print_endline "Pilha de Valor:";
    print_endline (string_of_stack valueStack string_of_value_stack);
    print_endline "Ambiente:";
    print_string "{";
    (string_of_dictionary  (Environment.iter string_of_bindable_dictionary environment));
    print_string "}\n";
    print_endline "Memória:";
    print_string "{";
     (string_of_dictionary  ( Memory.iter string_of_storable_dictionary memory));
    print_string "}\n";
    print_endline "#####################################################################################################################";

    let ctrl = (Stack.pop controlStack) in
      match ctrl with
      | Statement(sta)-> (
      
        match sta with
        | Exp (exp) -> (
          match exp with 
          | Id(id) -> (
            let key = Environment.find id environment in
              match key with 
                | Value(x) -> ();
                | Loc(x) -> (
                  let value = Memory.find x memory in
                    match value with
                    | Integer(x) ->   (Stack.push (Int(x)) valueStack);
                    | Boolean(x) ->  (Stack.push (Bool(x)) valueStack);
                )
            );
          | AExp(aExp) -> (
              match aExp with 
              | Num(x) -> (
                  (Stack.push (Int(x)) valueStack);
                );
              | Sum(AExp(x), AExp(y)) -> (
                (Stack.push (ExpOc(OPSUM)) controlStack);
                (Stack.push (Statement(Exp(AExp(y)))) controlStack);
                (Stack.push (Statement(Exp(AExp(x)))) controlStack);
              );
              | Sum(Id(x), AExp(y)) -> (
                (Stack.push (ExpOc(OPSUM)) controlStack);
                (Stack.push (Statement(Exp(AExp(y)))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              ); 
              | Sum(AExp(x), Id(y)) ->  (
                (Stack.push (ExpOc(OPSUM)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(AExp(x)))) controlStack);
              ); 
              | Sum(Id(x), Id(y)) ->  (
                (Stack.push (ExpOc(OPSUM)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              );
              | Sum(_, _) -> raise (AutomatonException "error on sum");          
              
              | Sub(AExp(x), AExp(y)) -> (
                (Stack.push (ExpOc(OPSUB)) controlStack);
                (Stack.push (Statement(Exp(AExp(y)))) controlStack);
                (Stack.push (Statement(Exp(AExp(x)))) controlStack);
              );
              | Sub(Id(x), AExp(y)) -> (
                (Stack.push (ExpOc(OPSUB)) controlStack);
                (Stack.push (Statement(Exp(AExp(y)))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              ); 
              | Sub(AExp(x), Id(y)) ->  (
                (Stack.push (ExpOc(OPSUB)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(AExp(x)))) controlStack);
              ); 
              | Sub(Id(x), Id(y)) ->  (
                (Stack.push (ExpOc(OPSUB)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              ); 
              | Sub(_, _) -> raise (AutomatonException "error on sub");
              | Mul(AExp(x), AExp(y)) -> (
                (Stack.push (ExpOc(OPMUL)) controlStack);
                (Stack.push (Statement(Exp(AExp(y)))) controlStack);
                (Stack.push (Statement(Exp(AExp(x)))) controlStack);
              );
              | Mul(Id(x), AExp(y)) -> (
                (Stack.push (ExpOc(OPMUL)) controlStack);
                (Stack.push (Statement(Exp(AExp(y)))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              ); 
              | Mul(AExp(x), Id(y)) ->  (
                (Stack.push (ExpOc(OPMUL)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(AExp(x)))) controlStack);
              ); 
              | Mul(Id(x), Id(y)) ->  (
                (Stack.push (ExpOc(OPMUL)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              ); 
              | Mul(_, _) -> raise (AutomatonException "error on Mul");
              | Div(AExp(x), AExp(y)) -> (
                (Stack.push (ExpOc(OPDIV)) controlStack);
                (Stack.push (Statement(Exp(AExp(y)))) controlStack);
                (Stack.push (Statement(Exp(AExp(x)))) controlStack);
              );
              | Div(Id(x), AExp(y)) -> (
                (Stack.push (ExpOc(OPDIV)) controlStack);
                (Stack.push (Statement(Exp(AExp(y)))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              ); 
              | Div(AExp(x), Id(y)) ->  (
                (Stack.push (ExpOc(OPDIV)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(AExp(x)))) controlStack);
              ); 
              | Div(Id(x), Id(y)) ->  (
                (Stack.push (ExpOc(OPDIV)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              ); 
              | Div(_, _) -> raise (AutomatonException "error on Div");     
            );
          | BExp(bExp)-> ( 
            match bExp with 
              | Boo(x) -> (
                (Stack.push (Bool(x)) valueStack);
              );
              | Eq(BExp(x), BExp(y)) -> (
                (Stack.push (ExpOc(OPEQ)) controlStack);
                (Stack.push (Statement(Exp(BExp(y)))) controlStack);
                (Stack.push (Statement(Exp(BExp(x)))) controlStack);
              );
              | Eq(BExp(x), Id(y)) -> (
                (Stack.push (ExpOc(OPEQ)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(BExp(x)))) controlStack);
              );
              | Eq(Id(x), BExp(y)) -> (
                (Stack.push (ExpOc(OPEQ)) controlStack);
                (Stack.push (Statement(Exp(BExp(y)))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              );
              | Eq(Id(x), Id(y)) -> (
                (Stack.push (ExpOc(OPEQ)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              );(* equals aritmetico *)
              | Eq(AExp(x), AExp(y)) -> (
                (Stack.push (ExpOc(OPEQ)) controlStack);
                (Stack.push (Statement(Exp(AExp(y)))) controlStack);
                (Stack.push (Statement(Exp(AExp(x)))) controlStack);
              );
              | Eq(AExp(x), Id(y)) -> (
                (Stack.push (ExpOc(OPEQ)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(AExp(x)))) controlStack);
              );
              | Eq(Id(x), AExp(y)) -> (
                (Stack.push (ExpOc(OPEQ)) controlStack);
                (Stack.push (Statement(Exp(AExp(y)))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              );(* fim equals aritmetico *)
              | Lt(AExp(x), AExp(y)) -> (
                (Stack.push (ExpOc(OPLT)) controlStack);
                (Stack.push (Statement(Exp(AExp(y)))) controlStack);
                (Stack.push (Statement(Exp(AExp(x)))) controlStack);
              );
              | Lt(AExp(x), Id(y)) -> (
                (Stack.push (ExpOc(OPLT)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(AExp(x)))) controlStack);
              );
              | Lt(Id(x), AExp(y)) -> (
                (Stack.push (ExpOc(OPLT)) controlStack);
                (Stack.push (Statement(Exp(AExp(y)))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              );
              | Lt(Id(x), Id(y)) -> (
                (Stack.push (ExpOc(OPLT)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              );
              | Le(AExp(x), AExp(y)) -> (
                (Stack.push (ExpOc(OPLE)) controlStack);
                (Stack.push (Statement(Exp(AExp(y)))) controlStack);
                (Stack.push (Statement(Exp(AExp(x)))) controlStack);
              );
              | Le(AExp(x), Id(y)) -> (
                (Stack.push (ExpOc(OPLE)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(AExp(x)))) controlStack);
              );
              | Le(Id(x), AExp(y)) -> (
                (Stack.push (ExpOc(OPLE)) controlStack);
                (Stack.push (Statement(Exp(AExp(y)))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              );
              | Le(Id(x), Id(y)) -> (
                (Stack.push (ExpOc(OPLE)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              );
              | Gt(AExp(x), AExp(y)) -> (
                (Stack.push (ExpOc(OPGT)) controlStack);
                (Stack.push (Statement(Exp(AExp(y)))) controlStack);
                (Stack.push (Statement(Exp(AExp(x)))) controlStack);
              );
              | Gt(AExp(x), Id(y)) -> (
                (Stack.push (ExpOc(OPGT)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(AExp(x)))) controlStack);
              );
              | Gt(Id(x), AExp(y)) -> (
                (Stack.push (ExpOc(OPGT)) controlStack);
                (Stack.push (Statement(Exp(AExp(y)))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              );
              | Gt(Id(x), Id(y)) -> (
                (Stack.push (ExpOc(OPGT)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              );
              | Ge(AExp(x), AExp(y)) -> (
                (Stack.push (ExpOc(OPGE)) controlStack);
                (Stack.push (Statement(Exp(AExp(y)))) controlStack);
                (Stack.push (Statement(Exp(AExp(x)))) controlStack);
              );
              | Ge(AExp(x), Id(y)) -> (
                (Stack.push (ExpOc(OPGE)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(AExp(x)))) controlStack);
              );
              | Ge(Id(x), AExp(y)) -> (
                (Stack.push (ExpOc(OPGE)) controlStack);
                (Stack.push (Statement(Exp(AExp(y)))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              );
              | Ge(Id(x), Id(y)) -> (
                (Stack.push (ExpOc(OPGE)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              );
              | And(BExp(x), BExp(y)) -> (
                (Stack.push (ExpOc(OPAND)) controlStack);
                (Stack.push (Statement(Exp(BExp(y)))) controlStack);
                (Stack.push (Statement(Exp(BExp(x)))) controlStack);
              );
              | And(BExp(x), Id(y)) -> (
                (Stack.push (ExpOc(OPAND)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(BExp(x)))) controlStack);
              );
              | And(Id(x), BExp(y)) -> (
                (Stack.push (ExpOc(OPAND)) controlStack);
                (Stack.push (Statement(Exp(BExp(y)))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              );
              | And(Id(x), Id(y)) -> (
                (Stack.push (ExpOc(OPAND)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              );
              | Or(BExp(x), BExp(y)) -> (
                (Stack.push (ExpOc(OPOR)) controlStack);
                (Stack.push (Statement(Exp(BExp(y)))) controlStack);
                (Stack.push (Statement(Exp(BExp(x)))) controlStack);
              );
              | Or(BExp(x), Id(y)) -> (
                (Stack.push (ExpOc(OPOR)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(BExp(x)))) controlStack);
              );
              | Or(Id(x), BExp(y)) -> (
                (Stack.push (ExpOc(OPOR)) controlStack);
                (Stack.push (Statement(Exp(BExp(y)))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              );
              | Or(Id(x), Id(y)) -> (
                (Stack.push (ExpOc(OPOR)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              );
              | _ -> raise (AutomatonException "error boolean");
            );
  
          
          )
      );
      
    evaluatePi controlStack valueStack environment memory;
  end else begin
    print_endline "End of Automaton Evaluation";
  end;;

(*
 let rec evaluatePi2 (controlStack : control list) (valueStack : control list) (enviroment : (string * int) list) (memory : (int * storable) list) =

  print_endline "Pilha de Controle:";
  print_endline (string_of_pi_list controlStack);
  print_endline "Pilha de Valor:";
  print_endline (string_of_pi_list valueStack);
  print_endline "#####################################################################################################################";


  match controlStack with 
    | Statement(sta)::tl -> (
      match sta with
      | Exp (exp) -> (
        match exp with 
        | Id(id) -> ();
        | AExp(aExp) -> (
          match aExp with 
          | Num(x) -> evaluatePi (List.tl controlStack) ((List.hd controlStack)::valueStack) enviroment memory;
          | Sum(AExp(x), AExp(y)) ->  evaluatePi  (Statement(Exp(AExp(x)))::Statement(Exp(AExp(y)))::ExpOc(OPSUM)::(List.tl controlStack))  ( valueStack ) enviroment memory
          | Sum(Id(x), AExp(y)) -> evaluatePi  (Statement(Exp(Id(x)))::Statement(Exp(AExp(y)))::ExpOc(OPSUM)::(List.tl controlStack))  ( valueStack ) enviroment memory
          | Sum(AExp(x), Id(y)) -> evaluatePi  (Statement(Exp(AExp(x)))::Statement(Exp(Id(y)))::ExpOc(OPSUM)::(List.tl controlStack))  ( valueStack ) enviroment memory
          | Sum(Id(x), Id(y)) -> evaluatePi  (Statement(Exp(Id(x)))::Statement(Exp(Id(y)))::ExpOc(OPSUM)::(List.tl controlStack))  ( valueStack ) enviroment memory
          | Sum(_, _) -> raise (AutomatonException "error on sum");
          | Sub(x, y) -> evaluatePi  (Statement(Exp(AExp(x)))::Statement(Exp(AExp(y)))::ExpOc(OPSUB)::(List.tl controlStack))  ( valueStack ) enviroment memory
          | Mul(x, y) -> evaluatePi  (Statement(Exp(AExp(x)))::Statement(Exp(AExp(y)))::ExpOc(OPMUL)::(List.tl controlStack))  ( valueStack ) enviroment memory
          | Div(x, y) -> evaluatePi  (Statement(Exp(AExp(x)))::Statement(Exp(AExp(y)))::ExpOc(OPDIV)::(List.tl controlStack))  ( valueStack ) enviroment memory
        );
        | BExp(bExp) -> (
          match bExp with 
          | Boo(x) -> evaluatePi (List.tl controlStack) ((List.hd controlStack)::valueStack) enviroment memory;
          | Eq(x, y) -> evaluatePi  (Statement(Exp(x))::Statement(Exp(y))::ExpOc(OPEQ)::(List.tl controlStack))  ( valueStack ) enviroment memory
          | Lt(x, y) -> evaluatePi  (Statement(Exp(AExp(x)))::Statement(Exp(AExp(y)))::ExpOc(OPLT)::(List.tl controlStack))  ( valueStack ) enviroment memory
          | Le(x, y) -> evaluatePi  (Statement(Exp(AExp(x)))::Statement(Exp(AExp(y)))::ExpOc(OPLE)::(List.tl controlStack))  ( valueStack ) enviroment memory
          | Gt(x, y) -> evaluatePi  (Statement(Exp(AExp(x)))::Statement(Exp(AExp(y)))::ExpOc(OPGT)::(List.tl controlStack))  ( valueStack ) enviroment memory
          | Ge(x, y) -> evaluatePi  (Statement(Exp(AExp(x)))::Statement(Exp(AExp(y)))::ExpOc(OPGE)::(List.tl controlStack))  ( valueStack ) enviroment memory
          | And(x, y) -> evaluatePi  (Statement(Exp(BExp(x)))::Statement(Exp(BExp(y)))::ExpOc(OPAND)::(List.tl controlStack))  ( valueStack ) enviroment memory
          | Or(x, y) -> evaluatePi  (Statement(Exp(BExp(x)))::Statement(Exp(BExp(y)))::ExpOc(OPOR)::(List.tl controlStack))  ( valueStack ) enviroment memory
          | Not(x) -> evaluatePi  (Statement(Exp(BExp(x)))::ExpOc(OPNOT)::(List.tl controlStack))  ( valueStack ) enviroment memory
        );
      );
      | Cmd(cmd) -> (
        match cmd with 
        | Loop(x, y) -> evaluatePi  (Statement(Exp(BExp(x)))::CmdOc(OPLOOP)::(List.tl controlStack))  (Statement(Cmd(Loop(x, y)))::valueStack ) enviroment memory
        | CSeq(x, y) -> evaluatePi  (Statement(Cmd(x))::Statement(Cmd(y))::(List.tl controlStack))  ( valueStack ) enviroment memory
        | Assign(x, y) -> evaluatePi  (Statement(Exp(y))::CmdOc(OPASSIGN)::(List.tl controlStack))  ( Statement(Exp(x))::valueStack ) enviroment memory
        | Cond(x, y, z) -> evaluatePi  (Statement(Exp(BExp(x)))::CmdOc(OPCOND)::(List.tl controlStack))  (Statement(Cmd(Cond(x, y, z)))::valueStack ) enviroment memory
        | Nop -> evaluatePi  (List.tl controlStack) (valueStack) enviroment memory
      );
    )
    | ExpOc(expOc)::tl -> (
      match expOc with 
      | OPSUM -> (
        match valueStack with
        | Statement(Exp(AExp(Num(x))))::tl -> (
          match tl with 
          |  Statement(Exp(AExp(Num(y))))::tl2 -> ( 
            evaluatePi (List.tl controlStack) ( Statement(Exp(AExp(Num(x + y)))) :: tl2 ) enviroment memory
          );
          | _ -> raise (AutomatonException "error on opsum")
        )
        | _ -> raise (AutomatonException "error on opsum");

      );
      | OPMUL -> (
        match valueStack with
        | Statement(Exp(AExp(Num(x))))::tl -> (
          match tl with 
          |  Statement(Exp(AExp(Num(y))))::tl2 -> ( 
            evaluatePi (List.tl controlStack) ( Statement(Exp(AExp(Num(x * y)))) :: tl2 ) enviroment memory
          );
          | _ -> raise (AutomatonException "error on opmul")
        )
        | _ -> raise (AutomatonException "error on opmul");

      );
      | OPSUB -> (
        match valueStack with
        | Statement(Exp(AExp(Num(x))))::tl -> (
          match tl with 
          |  Statement(Exp(AExp(Num(y))))::tl2 -> ( 
            evaluatePi (List.tl controlStack) ( Statement(Exp(AExp(Num(y - x)))) :: tl2 ) enviroment memory
          );
          | _ -> raise (AutomatonException "error on opsub")
        )
        | _ -> raise (AutomatonException "error on opsub");

      );
      | OPDIV -> (
        match valueStack with
        | Statement(Exp(AExp(Num(x))))::tl -> (
          match tl with 
          |  Statement(Exp(AExp(Num(y))))::tl2 -> ( 
            evaluatePi (List.tl controlStack) ( Statement(Exp(AExp(Num(y / x)))) :: tl2 ) enviroment memory
          );
          | _ -> raise (AutomatonException "error on opdiv")
        )
        | _ -> raise (AutomatonException "error on opdiv");
      );
      | OPEQ -> (
        match valueStack with
        | Statement(Exp(AExp(Num(x))))::tl -> (
          match tl with 
          |  Statement(Exp(AExp(Num(y))))::tl2 -> ( 
            evaluatePi (List.tl controlStack) ( Statement(Exp(BExp(Boo(y == x)))) :: tl2 ) enviroment memory
          );
          | _ -> raise (AutomatonException "error on opeq")
        )
        | _ -> raise (AutomatonException "error on opeq");

      );
      | OPLT -> (
        match valueStack with
        | Statement(Exp(AExp(Num(x))))::tl -> (
          match tl with 
          |  Statement(Exp(AExp(Num(y))))::tl2 -> ( 
            evaluatePi (List.tl controlStack) ( Statement(Exp(BExp(Boo(y < x)))) :: tl2 ) enviroment memory
          );
          | _ -> raise (AutomatonException "error on oplt")
        )
        | _ -> raise (AutomatonException "error on oplt");

      );
      | OPLE -> (
        match valueStack with
        | Statement(Exp(AExp(Num(x))))::tl -> (
          match tl with 
          |  Statement(Exp(AExp(Num(y))))::tl2 -> ( 
            evaluatePi (List.tl controlStack) ( Statement(Exp(BExp(Boo(y <= x)))) :: tl2 ) enviroment memory
          );
          | _ -> raise (AutomatonException "error on ople")
        )
        | _ -> raise (AutomatonException "error on opsle");

      );
      | OPGT -> (
        match valueStack with
        | Statement(Exp(AExp(Num(x))))::tl -> (
          match tl with 
          |  Statement(Exp(AExp(Num(y))))::tl2 -> ( 
            evaluatePi (List.tl controlStack) ( Statement(Exp(BExp(Boo(y > x)))) :: tl2 ) enviroment memory
          );
          | _ -> raise (AutomatonException "error on opgt")
        )
        | _ -> raise (AutomatonException "error on opgt");

      );
      | OPGE -> (
        match valueStack with
        | Statement(Exp(AExp(Num(x))))::tl -> (
          match tl with 
          |  Statement(Exp(AExp(Num(y))))::tl2 -> ( 
            evaluatePi (List.tl controlStack) ( Statement(Exp(BExp(Boo(y >= x)))) :: tl2 ) enviroment memory
          );
          | _ -> raise (AutomatonException "error on opge")
        )
        | _ -> raise (AutomatonException "error on opge");

      );
      | OPAND -> (
        match valueStack with
        | Statement(Exp(BExp(Boo(x))))::tl -> (
          match tl with 
          |  Statement(Exp(BExp(Boo(y))))::tl2 -> ( 
            evaluatePi (List.tl controlStack) ( Statement(Exp(BExp (Boo(y && x)))) :: tl2 ) enviroment memory
          );
          | _ -> raise (AutomatonException "error on opand")
        )
        | _ -> raise (AutomatonException "error on opand");
      );
      | OPOR -> (
        match valueStack with
        | Statement(Exp(BExp(Boo(x))))::tl -> (
          match tl with 
          |  Statement(Exp(BExp(Boo(y))))::tl2 -> ( 
            evaluatePi (List.tl controlStack) ( Statement(Exp(BExp(Boo(y || x)))) :: tl2 ) enviroment memory
          );
          | _ -> raise (AutomatonException "error on opor")
        )
        | _ -> raise (AutomatonException "error on opor");
      );
      | OPNOT -> (
        match valueStack with
          Statement(Exp(BExp(Boo(x))))::tl -> evaluatePi (List.tl controlStack) ( Statement(Exp(BExp(Boo(not (x))))) :: tl ) enviroment memory
        | _ -> raise (AutomatonException "error on opnot");
      );
    );
    | CmdOc(cmdOc)::tl -> (
      match cmdOc with 
      | OPASSIGN -> print_endline "teste"; print_endline "OPASSIGN";
      | OPLOOP -> (
        match valueStack with
        | Statement(Exp(BExp(Boo(x))))::tl -> (
          match tl with 
          |  Statement(Cmd(Loop(y, z)))::tl2 -> ( 
            if x == true then (evaluatePi (Statement(Cmd(z)) :: Statement(Cmd(Loop(y, z))) :: (List.tl controlStack)) (tl2)  enviroment memory) else (evaluatePi (List.tl controlStack) (tl2) enviroment memory)
          );
          | _ -> raise (AutomatonException "error on oploop")
        )
        | _ -> raise (AutomatonException "error on oploop");
      );
      | OPCOND -> (
        match valueStack with
        | Statement(Exp(BExp(Boo(x))))::tl -> (
          match tl with 
          |  Statement(Cmd(Cond(y, z, w)))::tl2 -> ( 
            if x == true then (evaluatePi (Statement(Cmd(z)) :: (List.tl controlStack)) (tl2) enviroment memory) else (evaluatePi (Statement(Cmd(w)) :: (List.tl controlStack)) (tl2) enviroment memory)
          );
          | _ -> raise (AutomatonException "error on opcond")
        )
        | _ -> raise (AutomatonException "error on opcond");
      );
    )
    | [] -> print_endline "Process Finished";; *)