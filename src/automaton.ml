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
          | Sum(x, y) -> evaluatePi  (Statement(Exp(AExp(x)))::Statement(Exp(AExp(y)))::ExpOc(OPSUM)::(List.tl controlStack))  ( valueStack   )
          | Sub(x, y) -> print_endline "teste";
          | Mul(x, y) -> print_endline "teste";
          | Div(x, y) -> print_endline "teste";
        );
        | BExp(bExp) -> (
          match bExp with 
          | Boo(x) -> print_endline "num";
          | Eq(x, y) -> print_endline "teste";
          | Lt(x, y) -> print_endline "teste";
          | Le(x, y) -> print_endline "teste";
          | Gt(x, y) -> print_endline "teste";
          | Ge(x, y) -> print_endline "teste";
          | And(x, y) -> print_endline "teste";
          | Or(x, y) -> print_endline "teste";
          | Not(x) -> print_endline "teste";
        );
      );
      | Cmd(cmd) -> (
        match cmd with 
        | Loop(x, y) -> print_endline "teste";
        | CSeq(x, y) -> print_endline "teste";
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
      | OPMUL -> print_endline "teste"; print_endline "opmul";
      | OPSUB -> print_endline "teste"; print_endline "opsum";
      | OPDIV -> print_endline "teste"; print_endline "opmul";
      | OPEQ -> print_endline "teste"; print_endline "opsum";
      | OPLT -> print_endline "teste"; print_endline "opmul";
      | OPLE -> print_endline "teste"; print_endline "opsum";
      | OPGT -> print_endline "teste"; print_endline "opmul";
      | OPGE -> print_endline "teste"; print_endline "opsum";
      | OPAND -> print_endline "teste"; print_endline "opmul";
      | OPOR -> print_endline "teste"; print_endline "opsum";
      | OPNOT -> print_endline "teste"; print_endline "opmul";
    );
    | CmdOc(cmdOc)::tl -> (
      match cmdOc with 
      | OPASSIGN -> print_endline "teste"; print_endline "OPASSIGN";
      | OPLOOP -> print_endline "teste"; print_endline "OPLOOP";
      | OPCOND -> print_endline "teste"; print_endline "OPCOND";
    )
    | [] -> print_endline "terminou!!!";;

