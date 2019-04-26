open Util;;
open Pi;;

exception Foo of string;;


let rec evaluatePi (controlStack : control list) (valueStack : control list)   =

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
          | Num(x) -> evaluatePi (List.tl controlStack) ((List.hd controlStack)::valueStack);
          | Sum(x, y) -> evaluatePi  (Statement(Exp(AExp(x)))::Statement(Exp(AExp(y)))::ExpOc(OPSUM)::(List.tl controlStack))  ( valueStack )
          | Sub(x, y) -> evaluatePi  (Statement(Exp(AExp(x)))::Statement(Exp(AExp(y)))::ExpOc(OPSUB)::(List.tl controlStack))  ( valueStack )
          | Mul(x, y) -> evaluatePi  (Statement(Exp(AExp(x)))::Statement(Exp(AExp(y)))::ExpOc(OPMUL)::(List.tl controlStack))  ( valueStack )
          | Div(x, y) -> print_endline "teste";
        );
        | BExp(bExp) -> (
          match bExp with 
          | Boo(x) -> print_endline "num";
          | Eq(x, y) -> evaluatePi  (Statement(Exp(x))::Statement(Exp(y))::ExpOc(OPEQ)::(List.tl controlStack))  ( valueStack )
          | Lt(x, y) -> evaluatePi  (Statement(Exp(AExp(x)))::Statement(Exp(AExp(y)))::ExpOc(OPLT)::(List.tl controlStack))  ( valueStack )
          | Le(x, y) -> evaluatePi  (Statement(Exp(AExp(x)))::Statement(Exp(AExp(y)))::ExpOc(OPLE)::(List.tl controlStack))  ( valueStack )
          | Gt(x, y) -> evaluatePi  (Statement(Exp(AExp(x)))::Statement(Exp(AExp(y)))::ExpOc(OPGT)::(List.tl controlStack))  ( valueStack )
          | Ge(x, y) -> evaluatePi  (Statement(Exp(AExp(x)))::Statement(Exp(AExp(y)))::ExpOc(OPGE)::(List.tl controlStack))  ( valueStack )
          | And(x, y) -> evaluatePi  (Statement(Exp(BExp(x)))::Statement(Exp(BExp(y)))::ExpOc(OPAND)::(List.tl controlStack))  ( valueStack )
          | Or(x, y) -> print_endline "teste";
          | Not(x) -> print_endline "teste";
        );
      );
      | Cmd(cmd) -> (
        match cmd with 
        | Loop(x, y) -> evaluatePi  (Statement(Exp(BExp(x)))::Statement(Cmd(y))::CmdOc(OPLOOP)::(List.tl controlStack))  ( valueStack )
        | CSeq(x, y) -> evaluatePi  (Statement(Cmd(x))::Statement(Cmd(y))::CmdOc(OPCSEQ)::(List.tl controlStack))  ( valueStack )
        | Assign(x, y) -> print_endline "teste";
        | Cond(x, y, z) -> print_endline "teste";
        | Nop -> print_endline "teste";
      );
    )
    | ExpOc(expOc)::tl -> (
      match expOc with 
      | OPSUM -> (
        match valueStack with
        | Statement(Exp(AExp(Num(x))))::tl -> (
          match tl with 
          |  Statement(Exp(AExp(Num(y))))::tl2 -> ( 
            evaluatePi (List.tl controlStack) ( Statement(Exp(AExp(Num(x + y)))) :: tl2 )
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
            evaluatePi (List.tl controlStack) ( Statement(Exp(AExp(Num(x * y)))) :: tl2 )
          );
          | _ -> raise (Foo "error on opmum")
        )
        | _ -> raise (Foo "error on opmum");

      );
      | OPSUB -> (
        match valueStack with
        | Statement(Exp(AExp(Num(x))))::tl -> (
          match tl with 
          |  Statement(Exp(AExp(Num(y))))::tl2 -> ( 
            evaluatePi (List.tl controlStack) ( Statement(Exp(AExp(Num(y - x)))) :: tl2 )
          );
          | _ -> raise (Foo "error on opsub")
        )
        | _ -> raise (Foo "error on opsub");

      );
      | OPDIV -> print_endline "teste"; print_endline "opmul";
      | OPEQ -> (
        match valueStack with
        | Statement(Exp(AExp(Num(x))))::tl -> (
          match tl with 
          |  Statement(Exp(AExp(Num(y))))::tl2 -> ( 
            evaluatePi (List.tl controlStack) ( Statement(Exp(BExp(Boo(y == x)))) :: tl2 )
          );
          | _ -> raise (Foo "error on opsum")
        )
        | _ -> raise (Foo "error on opsum");

      );
      | OPLT -> (
        match valueStack with
        | Statement(Exp(AExp(Num(x))))::tl -> (
          match tl with 
          |  Statement(Exp(AExp(Num(y))))::tl2 -> ( 
            evaluatePi (List.tl controlStack) ( Statement(Exp(BExp(Boo(y < x)))) :: tl2 )
          );
          | _ -> raise (Foo "error on opsum")
        )
        | _ -> raise (Foo "error on opsum");

      );
      | OPLE -> (
        match valueStack with
        | Statement(Exp(AExp(Num(x))))::tl -> (
          match tl with 
          |  Statement(Exp(AExp(Num(y))))::tl2 -> ( 
            evaluatePi (List.tl controlStack) ( Statement(Exp(BExp(Boo(y <= x)))) :: tl2 )
          );
          | _ -> raise (Foo "error on opsum")
        )
        | _ -> raise (Foo "error on opsum");

      );
      | OPGT -> (
        match valueStack with
        | Statement(Exp(AExp(Num(x))))::tl -> (
          match tl with 
          |  Statement(Exp(AExp(Num(y))))::tl2 -> ( 
            evaluatePi (List.tl controlStack) ( Statement(Exp(BExp(Boo(y > x)))) :: tl2 )
          );
          | _ -> raise (Foo "error on opsum")
        )
        | _ -> raise (Foo "error on opsum");

      );
      | OPGE -> (
        match valueStack with
        | Statement(Exp(AExp(Num(x))))::tl -> (
          match tl with 
          |  Statement(Exp(AExp(Num(y))))::tl2 -> ( 
            evaluatePi (List.tl controlStack) ( Statement(Exp(BExp(Boo(y >= x)))) :: tl2 )
          );
          | _ -> raise (Foo "error on opsum")
        )
        | _ -> raise (Foo "error on opsum");

      );
      | OPAND -> print_endline "teste"; print_endline "opmul";
      | OPOR -> print_endline "teste"; print_endline "opsum";
      | OPNOT -> print_endline "teste"; print_endline "opmul";
    );
    | CmdOc(cmdOc)::tl -> (
      match cmdOc with 
      | OPASSIGN -> print_endline "teste"; print_endline "OPASSIGN";
      | OPLOOP -> print_endline "teste"; print_endline "OPLOOP";
      | OPCOND -> print_endline "teste"; print_endline "OPCOND";
      | OPCSEQ -> print_endline "teste"; print_endline "OPCOND";
    )
    | [] -> print_endline "terminou!!!";;

