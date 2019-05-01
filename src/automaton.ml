open Util;;
open Pi;;

exception Foo of string;;


let rec evaluatePi (controlStack : control list) (valueStack : control list) (enviroment : 'a Dictionary.AssocList.dict) (memory : 'a Dictionary.AssocList.dict) =

  print_endline "\n";
  print_endline "Pilha de Controle:";
  print_endline (string_of_pi_list controlStack);
  print_endline "Pilha de Valor:";
  print_endline (string_of_pi_list valueStack);

  match controlStack with 
    | Statement(sta)::tl -> (
      match sta with
      | Exp (exp) -> (
        match exp with 
        | AExp(aExp) -> (
          match aExp with 
          | Num(x) -> evaluatePi (List.tl controlStack) ((List.hd controlStack)::valueStack) enviroment memory;
          | Sum(x, y) -> evaluatePi  (Statement(Exp(AExp(x)))::Statement(Exp(AExp(y)))::ExpOc(OPSUM)::(List.tl controlStack))  ( valueStack ) enviroment memory
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
      | Id(id) -> ();
      | Cmd(cmd) -> (
        match cmd with 
        | Loop(x, y) -> evaluatePi  (Statement(Exp(BExp(x)))::CmdOc(OPLOOP)::(List.tl controlStack))  (Statement(Cmd(Loop(x, y)))::valueStack ) enviroment memory
        | CSeq(x, y) -> evaluatePi  (Statement(Cmd(x))::Statement(Cmd(y))::(List.tl controlStack))  ( valueStack ) enviroment memory
        | Assign(x, y) -> evaluatePi  (Statement(Exp(y))::CmdOc(OPASSIGN)::(List.tl controlStack))  ( Statement(Id(x))::valueStack ) enviroment memory
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
          | _ -> raise (Foo "error on opsum")
        )
        | _ -> raise (Foo "error on opsum");

      );
      | OPMUL -> (
        match valueStack with
        | Statement(Exp(AExp(Num(x))))::tl -> (
          match tl with 
          |  Statement(Exp(AExp(Num(y))))::tl2 -> ( 
            evaluatePi (List.tl controlStack) ( Statement(Exp(AExp(Num(x * y)))) :: tl2 ) enviroment memory
          );
          | _ -> raise (Foo "error on opmul")
        )
        | _ -> raise (Foo "error on opmul");

      );
      | OPSUB -> (
        match valueStack with
        | Statement(Exp(AExp(Num(x))))::tl -> (
          match tl with 
          |  Statement(Exp(AExp(Num(y))))::tl2 -> ( 
            evaluatePi (List.tl controlStack) ( Statement(Exp(AExp(Num(y - x)))) :: tl2 ) enviroment memory
          );
          | _ -> raise (Foo "error on opsub")
        )
        | _ -> raise (Foo "error on opsub");

      );
      | OPDIV -> (
        match valueStack with
        | Statement(Exp(AExp(Num(x))))::tl -> (
          match tl with 
          |  Statement(Exp(AExp(Num(y))))::tl2 -> ( 
            evaluatePi (List.tl controlStack) ( Statement(Exp(AExp(Num(x / y)))) :: tl2 ) enviroment memory
          );
          | _ -> raise (Foo "error on opdiv")
        )
        | _ -> raise (Foo "error on opdiv");
      );
      | OPEQ -> (
        match valueStack with
        | Statement(Exp(AExp(Num(x))))::tl -> (
          match tl with 
          |  Statement(Exp(AExp(Num(y))))::tl2 -> ( 
            evaluatePi (List.tl controlStack) ( Statement(Exp(BExp(Boo(y == x)))) :: tl2 ) enviroment memory
          );
          | _ -> raise (Foo "error on opeq")
        )
        | _ -> raise (Foo "error on opeq");

      );
      | OPLT -> (
        match valueStack with
        | Statement(Exp(AExp(Num(x))))::tl -> (
          match tl with 
          |  Statement(Exp(AExp(Num(y))))::tl2 -> ( 
            evaluatePi (List.tl controlStack) ( Statement(Exp(BExp(Boo(y < x)))) :: tl2 ) enviroment memory
          );
          | _ -> raise (Foo "error on oplt")
        )
        | _ -> raise (Foo "error on oplt");

      );
      | OPLE -> (
        match valueStack with
        | Statement(Exp(AExp(Num(x))))::tl -> (
          match tl with 
          |  Statement(Exp(AExp(Num(y))))::tl2 -> ( 
            evaluatePi (List.tl controlStack) ( Statement(Exp(BExp(Boo(y <= x)))) :: tl2 ) enviroment memory
          );
          | _ -> raise (Foo "error on ople")
        )
        | _ -> raise (Foo "error on opsle");

      );
      | OPGT -> (
        match valueStack with
        | Statement(Exp(AExp(Num(x))))::tl -> (
          match tl with 
          |  Statement(Exp(AExp(Num(y))))::tl2 -> ( 
            evaluatePi (List.tl controlStack) ( Statement(Exp(BExp(Boo(y > x)))) :: tl2 ) enviroment memory
          );
          | _ -> raise (Foo "error on opgt")
        )
        | _ -> raise (Foo "error on opgt");

      );
      | OPGE -> (
        match valueStack with
        | Statement(Exp(AExp(Num(x))))::tl -> (
          match tl with 
          |  Statement(Exp(AExp(Num(y))))::tl2 -> ( 
            evaluatePi (List.tl controlStack) ( Statement(Exp(BExp(Boo(y >= x)))) :: tl2 ) enviroment memory
          );
          | _ -> raise (Foo "error on opge")
        )
        | _ -> raise (Foo "error on opge");

      );
      | OPAND -> (
        match valueStack with
        | Statement(Exp(BExp(Boo(x))))::tl -> (
          match tl with 
          |  Statement(Exp(BExp(Boo(y))))::tl2 -> ( 
            evaluatePi (List.tl controlStack) ( Statement(Exp(BExp (Boo(y && x)))) :: tl2 ) enviroment memory
          );
          | _ -> raise (Foo "error on opand")
        )
        | _ -> raise (Foo "error on opand");
      );
      | OPOR -> (
        match valueStack with
        | Statement(Exp(BExp(Boo(x))))::tl -> (
          match tl with 
          |  Statement(Exp(BExp(Boo(y))))::tl2 -> ( 
            evaluatePi (List.tl controlStack) ( Statement(Exp(BExp(Boo(y || x)))) :: tl2 ) enviroment memory
          );
          | _ -> raise (Foo "error on opor")
        )
        | _ -> raise (Foo "error on opor");
      );
      | OPNOT -> (
        match valueStack with
          Statement(Exp(BExp(Boo(x))))::tl -> evaluatePi (List.tl controlStack) ( Statement(Exp(BExp(Boo(not (x))))) :: tl ) enviroment memory
        | _ -> raise (Foo "error on opnot");
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
          | _ -> raise (Foo "error on oploop")
        )
        | _ -> raise (Foo "error on oploop");
      );
      | OPCOND -> (
        match valueStack with
        | Statement(Exp(BExp(Boo(x))))::tl -> (
          match tl with 
          |  Statement(Cmd(Cond(y, z, w)))::tl2 -> ( 
            if x == true then (evaluatePi (Statement(Cmd(z)) :: (List.tl controlStack)) (tl2) enviroment memory) else (evaluatePi (Statement(Cmd(w)) :: (List.tl controlStack)) (tl2) enviroment memory)
          );
          | _ -> raise (Foo "error on opcond")
        )
        | _ -> raise (Foo "error on opcond");
      );
    )
    | [] -> print_endline "terminou!!!";;