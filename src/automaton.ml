open Util;;
open Pi;;
open AutomatonType;;

let trace = ref [];;

let rec delta controlStack valueStack environment memory locations = 
  
  let copia = !locations in
  trace := (!trace)@[( (Stack.copy controlStack), (Stack.copy valueStack), (Hashtbl.copy environment), (Hashtbl.copy memory), (copia))];

  (* Linha para debugar. apagar depois *)
  (* print_endline(string_of_iteration controlStack valueStack environment memory !locations );  *)
  
  if not(Stack.is_empty controlStack) then begin 
    
    let ctrl = (Stack.pop controlStack) in
      (match ctrl with
      | Statement(sta)-> (
        match sta with
        | Exp (exp) -> (
          match exp with 
          | Id(id) -> (
            let key = Hashtbl.find environment id  in
              match key with 
                | Loc(Location(x)) -> (
                  let value = Hashtbl.find memory x  in
                    match value with
                    | Integer(x) ->   (Stack.push (Int(x)) valueStack);
                    | Boolean(x) ->  (Stack.push (Bool(x)) valueStack);
                    | Pointer(p) -> (Stack.push (Bind(p)) valueStack);
                );
                | IntConst(i) -> (
                  (Stack.push (Int(i)) valueStack);
                );
                | BoolConst(b) -> (
                  (Stack.push (Bool(b)) valueStack);
                );
                | _ -> ();
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
              | Sum( ValRef(Id(x)), ValRef(Id(y)) ) ->  (
                (Stack.push (ExpOc(OPSUM)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Sum(ValRef(Id(x)), AExp(y)) ->  (
                (Stack.push (ExpOc(OPSUM)) controlStack);
                (Stack.push (Statement(Exp(AExp(y)))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Sum( AExp(x), ValRef(Id(y)) ) ->  (
                (Stack.push (ExpOc(OPSUM)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(AExp(x)))) controlStack);
              );
              | Sum(ValRef(Id(x)), Id(y)) ->  (
                (Stack.push (ExpOc(OPSUM)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Sum( Id(x), ValRef(Id(y)) ) ->  (
                (Stack.push (ExpOc(OPSUM)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              );
              | Sum(_, _) -> raise (AutomatonException "Error on Sum AEXP"); 
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
              | Sub( ValRef(Id(x)), ValRef(Id(y)) ) ->  (
                (Stack.push (ExpOc(OPSUB)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Sub(ValRef(Id(x)), AExp(y)) ->  (
                (Stack.push (ExpOc(OPSUB)) controlStack);
                (Stack.push (Statement(Exp(AExp(y)))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Sub( AExp(x), ValRef(Id(y)) ) ->  (
                (Stack.push (ExpOc(OPSUB)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(AExp(x)))) controlStack);
              );
              | Sub(ValRef(Id(x)), Id(y)) ->  (
                (Stack.push (ExpOc(OPSUB)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Sub( Id(x), ValRef(Id(y)) ) ->  (
                (Stack.push (ExpOc(OPSUB)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              ); 
              | Sub(_, _) -> raise (AutomatonException "Error on Sub");
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
              | Mul( ValRef(Id(x)), ValRef(Id(y)) ) ->  (
                (Stack.push (ExpOc(OPMUL)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Mul(ValRef(Id(x)), AExp(y)) ->  (
                (Stack.push (ExpOc(OPMUL)) controlStack);
                (Stack.push (Statement(Exp(AExp(y)))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Mul( AExp(x), ValRef(Id(y)) ) ->  (
                (Stack.push (ExpOc(OPMUL)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(AExp(x)))) controlStack);
              );
              | Mul(ValRef(Id(x)), Id(y)) ->  (
                (Stack.push (ExpOc(OPMUL)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Mul( Id(x), ValRef(Id(y)) ) ->  (
                (Stack.push (ExpOc(OPMUL)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              ); 
              | Mul(_, _) -> raise (AutomatonException "Error on Mul");
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
              | Div( ValRef(Id(x)), ValRef(Id(y)) ) ->  (
                (Stack.push (ExpOc(OPDIV)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Div(ValRef(Id(x)), AExp(y)) ->  (
                (Stack.push (ExpOc(OPDIV)) controlStack);
                (Stack.push (Statement(Exp(AExp(y)))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Div( AExp(x), ValRef(Id(y)) ) ->  (
                (Stack.push (ExpOc(OPDIV)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(AExp(x)))) controlStack);
              );
              | Div(ValRef(Id(x)), Id(y)) ->  (
                (Stack.push (ExpOc(OPDIV)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Div( Id(x), ValRef(Id(y)) ) ->  (
                (Stack.push (ExpOc(OPDIV)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              ); 
              | Div(_, _) -> raise (AutomatonException "Error on Div");     
            )
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
              );
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
              );
              | Eq(BExp(x), ValRef(Id(y)) )  -> (
                (Stack.push (ExpOc(OPEQ)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(BExp(x)))) controlStack);
              );
              | Eq( ValRef(Id(x)), BExp(y)) -> (
                (Stack.push (ExpOc(OPEQ)) controlStack);
                (Stack.push (Statement(Exp(BExp(y)))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Eq(ValRef(Id(x)), ValRef(Id(y))) -> (
                (Stack.push (ExpOc(OPEQ)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Eq(AExp(x), ValRef(Id(y))) -> (
                (Stack.push (ExpOc(OPEQ)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(AExp(x)))) controlStack);
              );
              | Eq(ValRef(Id(x)), AExp(y)) -> (
                (Stack.push (ExpOc(OPEQ)) controlStack);
                (Stack.push (Statement(Exp(AExp(y)))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Eq(Id(x), ValRef(Id(y))) -> (
                (Stack.push (ExpOc(OPEQ)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              );
              | Eq(ValRef(Id(x)), Id(y)) -> (
                (Stack.push (ExpOc(OPEQ)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Eq(_, _) -> raise (AutomatonException "Error on Eq"); 
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
              | Lt( ValRef(Id(x)), ValRef(Id(y)) ) ->  (
                (Stack.push (ExpOc(OPLT)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Lt(ValRef(Id(x)), AExp(y)) ->  (
                (Stack.push (ExpOc(OPLT)) controlStack);
                (Stack.push (Statement(Exp(AExp(y)))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Lt( AExp(x), ValRef(Id(y)) ) ->  (
                (Stack.push (ExpOc(OPLT)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(AExp(x)))) controlStack);
              );
              | Lt(ValRef(Id(x)), Id(y)) ->  (
                (Stack.push (ExpOc(OPLT)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Lt( Id(x), ValRef(Id(y)) ) ->  (
                (Stack.push (ExpOc(OPLT)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              ); 
              | Lt(_, _) -> raise (AutomatonException "Error on Lt"); 
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
              | Le( ValRef(Id(x)), ValRef(Id(y)) ) ->  (
                (Stack.push (ExpOc(OPLE)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Le(ValRef(Id(x)), AExp(y)) ->  (
                (Stack.push (ExpOc(OPLE)) controlStack);
                (Stack.push (Statement(Exp(AExp(y)))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Le( AExp(x), ValRef(Id(y)) ) ->  (
                (Stack.push (ExpOc(OPLE)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(AExp(x)))) controlStack);
              );
              | Le(ValRef(Id(x)), Id(y)) ->  (
                (Stack.push (ExpOc(OPLE)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Le( Id(x), ValRef(Id(y)) ) ->  (
                (Stack.push (ExpOc(OPLE)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              );
              | Le(_, _) -> raise (AutomatonException "Error on Le");
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
              | Gt( ValRef(Id(x)), ValRef(Id(y)) ) ->  (
                (Stack.push (ExpOc(OPGT)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Gt(ValRef(Id(x)), AExp(y)) ->  (
                (Stack.push (ExpOc(OPGT)) controlStack);
                (Stack.push (Statement(Exp(AExp(y)))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Gt( AExp(x), ValRef(Id(y)) ) ->  (
                (Stack.push (ExpOc(OPGT)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(AExp(x)))) controlStack);
              );
              | Gt(ValRef(Id(x)), Id(y)) ->  (
                (Stack.push (ExpOc(OPGT)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Gt( Id(x), ValRef(Id(y)) ) ->  (
                (Stack.push (ExpOc(OPGT)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              );
              | Gt(_, _) -> raise (AutomatonException "Error on Gt");
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
              | Ge( ValRef(Id(x)), ValRef(Id(y)) ) ->  (
                (Stack.push (ExpOc(OPGE)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Ge(ValRef(Id(x)), AExp(y)) ->  (
                (Stack.push (ExpOc(OPGE)) controlStack);
                (Stack.push (Statement(Exp(AExp(y)))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Ge( AExp(x), ValRef(Id(y)) ) ->  (
                (Stack.push (ExpOc(OPGE)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(AExp(x)))) controlStack);
              );
              | Ge(ValRef(Id(x)), Id(y)) ->  (
                (Stack.push (ExpOc(OPGE)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Ge( Id(x), ValRef(Id(y)) ) ->  (
                (Stack.push (ExpOc(OPGE)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              );
              | Ge(_, _) -> raise (AutomatonException "Error on Ge");
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
              | And( ValRef(Id(x)), ValRef(Id(y)) ) ->  (
                (Stack.push (ExpOc(OPAND)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | And (ValRef(Id(x)), BExp(y)) ->  (
                (Stack.push (ExpOc(OPAND)) controlStack);
                (Stack.push (Statement(Exp(BExp(y)))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | And ( BExp(x), ValRef(Id(y)) ) ->  (
                (Stack.push (ExpOc(OPAND)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(BExp(x)))) controlStack);
              );
              | And (ValRef(Id(x)), Id(y)) ->  (
                (Stack.push (ExpOc(OPAND)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | And ( Id(x), ValRef(Id(y)) ) ->  (
                (Stack.push (ExpOc(OPAND)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              );
              | And(_, _) -> raise (AutomatonException "Error on And");
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
              | Or( ValRef(Id(x)), ValRef(Id(y)) ) ->  (
                (Stack.push (ExpOc(OPOR)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Or (ValRef(Id(x)), BExp(y)) ->  (
                (Stack.push (ExpOc(OPOR)) controlStack);
                (Stack.push (Statement(Exp(BExp(y)))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Or ( BExp(x), ValRef(Id(y)) ) ->  (
                (Stack.push (ExpOc(OPOR)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(BExp(x)))) controlStack);
              );
              | Or (ValRef(Id(x)), Id(y)) ->  (
                (Stack.push (ExpOc(OPOR)) controlStack);
                (Stack.push (Statement(Exp(Id(y)))) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Or ( Id(x), ValRef(Id(y)) ) ->  (
                (Stack.push (ExpOc(OPOR)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(y))))) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              );
              | Or(_, _) -> raise (AutomatonException "Error on Or");
              | Not(BExp(x)) -> (
                (Stack.push (ExpOc(OPNOT)) controlStack);
                (Stack.push (Statement(Exp(BExp(x)))) controlStack);
              );
              | Not(Id(x)) -> (
                (Stack.push (ExpOc(OPNOT)) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              );
              | Not (ValRef(Id(x))) -> (
                (Stack.push (ExpOc(OPNOT)) controlStack);
                (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack);
              );
              | Not( _) -> raise (AutomatonException "Error on Not");  
            );   
            | Ref(ref)-> (
              (Stack.push (DecOc(OPREF)) controlStack);
              (Stack.push (Statement(Exp(ref))) controlStack);
            );
            | DeRef(ref) -> (
              match ref with
              | Id(id) -> (
                let key = Hashtbl.find environment id  in
                  match key with 
                  | Loc(x) -> (
                    (Stack.push (Bind(x)) valueStack );
                  );
                  |IntConst(x) -> (
                    raise (AutomatonException "Error on DeRef nao pode acessar endereco de constante - int ");
                  );
                  |BoolConst(x) -> (
                    raise (AutomatonException "Error on DeRef nao pode acessar endereco de constante - bool");
                  );
                  | _ -> ();
              );
              | _ -> raise (AutomatonException "Error on DeRef 666");
            );
            | ValRef(ref) -> (
              match ref with
              | Id(id) -> (
                let key = Hashtbl.find environment id  in
                match key with 
                  | Loc(Location(x1)) -> (
                    let value1 = Hashtbl.find memory x1  in
                      match value1 with
                      | Pointer(Location(x3)) -> (
                          let value2 = Hashtbl.find memory x3  in
                          match value2 with
                          | Integer(x4) ->   (Stack.push (Int(x4)) valueStack);
                          | Boolean(x4) ->  (Stack.push (Bool(x4)) valueStack);
                          | Pointer(x4) -> (Stack.push (Bind(x4)) valueStack);
                        );
                      | _ -> raise (AutomatonException "Error on ValRef1 not a pointer");
                  );
                  | _ ->   raise (AutomatonException "Error on ValRef2 not a location");
              );
              | _ ->   raise (AutomatonException "Error on ValRef3 not a id");
            );
          );
        | Cmd(cmd) -> (
          match cmd with 
          | Loop( BExp(x), y) -> (
            (Stack.push (CmdOc(OPLOOP)) controlStack);
            (Stack.push (Statement(Exp(BExp(x)))) controlStack );
            (Stack.push (LoopValue(Loop(BExp(x), y))) valueStack );   
          );
          | Loop(Id(x), y) -> (
            (Stack.push (CmdOc(OPLOOP)) controlStack);
            (Stack.push (Statement(Exp(Id(x)))) controlStack );
            (Stack.push (LoopValue(Loop(Id(x), y))) valueStack ); 
          );
          | Loop(ValRef(Id(x)), y) -> (
            (Stack.push (CmdOc(OPLOOP)) controlStack);
            (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack );
            (Stack.push (LoopValue(Loop(ValRef(Id(x)), y))) valueStack ); 
          );
          | Loop(_, _) -> raise (AutomatonException "Error on Loop");
          | CSeq(x, y) -> (
            (Stack.push (Statement(Cmd(y))) controlStack );
            (Stack.push (Statement(Cmd(x))) controlStack );
          );
          | Assign(Id(x), y) -> (
             (Stack.push (CmdOc(OPASSIGN)) controlStack );
             (Stack.push (Statement(Exp(y))) controlStack );
             (Stack.push (Str(x)) valueStack);
          );
          | Assign(_, _) -> raise (AutomatonException "Error on Assign");
          | Cond(BExp(x), y, z) -> (
            (Stack.push (CmdOc(OPCOND)) controlStack);
            (Stack.push (Statement(Exp(BExp(x)))) controlStack );
            (Stack.push (CondValue(Cond(BExp(x), y, z))) valueStack );
          );
          | Cond(Id(x), y, z) -> (
            (Stack.push (CmdOc(OPCOND)) controlStack);
            (Stack.push (Statement(Exp(Id(x)))) controlStack );
            (Stack.push (CondValue(Cond(Id(x), y, z))) valueStack );
          );
          | Cond(ValRef(Id(x)), y, z) -> (
            (Stack.push (CmdOc(OPCOND)) controlStack);
            (Stack.push (Statement(Exp(ValRef(Id(x))))) controlStack );
            (Stack.push (CondValue(Cond(ValRef(Id(x)), y, z))) valueStack );
          );
          | Cond(_, _, _) -> raise (AutomatonException "Error on Cond");
          | Blk(x, y) -> (
            (Stack.push (DecOc(OPBLKCMD)) controlStack);
            (Stack.push (Statement(Cmd(y))) controlStack);
            (Stack.push (DecOc(OPBLKDEC)) controlStack);
            (Stack.push (Statement(Dec(x))) controlStack);
            (Stack.push (Locations(!locations)) valueStack);
            locations := [] ;
          );
          | Nop -> ();
          | Call(id, actuals) -> (
            ( Stack.push (CmdOc (OPCALL(id, (List.length actuals))) )  controlStack );
            ( 
              List.iter 
              (
                fun parametro -> Stack.push (Statement(Exp(parametro))) controlStack 
              ) 
              actuals
            );
          );
        );
        | Dec (dec) -> (
          match dec with 
          | Bind(Id(x), y) -> (
            (Stack.push (DecOc(OPBIND)) controlStack );
            (Stack.push (Statement(Exp(y))) controlStack );
            (Stack.push (Str(x)) valueStack);
          );
          | BindAbs(Id(x), y) -> (
            (Stack.push (DecOc(OPBIND)) controlStack );
            (Stack.push (Statement(Abs(y))) controlStack );
            (Stack.push (Str(x)) valueStack);
          );
          | Rbnd(Id(x), AbsFunction(f, b)) -> (
            let topo = (Stack.pop valueStack) in
            (* TODO: Comentar esse caso com o professor *)
            match topo with 
            | Env(e) -> (
              (Hashtbl.add e x (Closure(f, b, (Hashtbl.copy environment))));
              (Stack.push (Env(reclose e (Hashtbl.copy environment) )) valueStack);
            );
            | _ -> (
              (Stack.push topo valueStack);
              let new_env = (Hashtbl.create 3) in
              (Hashtbl.add new_env x (Closure(f, b, (Hashtbl.copy environment))));
              (Stack.push (Env(reclose new_env (Hashtbl.copy environment) )) valueStack);
            );
            
          );
          | Bind(_, _) -> (
            raise (AutomatonException "Error on Bind" );
          );
          | DSeq(x, y) -> (
            (Stack.push (Statement(Dec(y))) controlStack);
            (Stack.push (Statement(Dec(x))) controlStack);
         );
         | _ ->(
           raise (AutomatonException "Error on DEC" )
         );
        );
        | Abs(x) -> 
          match x with
          | AbsFunction(f, b) -> (
            (Stack.push (Clos(f, b, (Hashtbl.copy environment))) valueStack)
        );

      );   
      | ExpOc(expOc) -> (
        match expOc with
        | OPSUM -> (
          let x = (Stack.pop valueStack) in
            match x with
              | Int(i) -> (
                let y = (Stack.pop valueStack) in
                match y with
                  | Int(j) -> (
                    (Stack.push (Int(i + j)) valueStack);
                  );
                  | _ -> raise (AutomatonException "Error on #SUM not a int j");
              );
              | _ -> raise (AutomatonException "Error on #SUM not a int i");
            );

        | OPMUL -> (
          let x = (Stack.pop valueStack) in
            match x with
              | Int(i) -> (
                let y = (Stack.pop valueStack) in
                match y with
                  | Int(j) -> (
                    (Stack.push (Int(i * j)) valueStack);      
                  );
                  | _ -> raise (AutomatonException "Error on #MUL not a int j");
              );
              | _ -> raise (AutomatonException "Error on #MUL not a int i");
            );

        | OPDIV -> (
          let x = (Stack.pop valueStack) in
            match x with
              | Int(i) -> (
                if (i == 0) then  
                  raise (AutomatonException "Error on #DIV. Division by 0") 
                else
                  let y = (Stack.pop valueStack) in
                match y with
                  | Int(j) -> (
                    (Stack.push (Int(j / i)) valueStack);      
                  )
                  | _ -> raise (AutomatonException "Error on #DIV not a int j");
              );
              | _ -> raise (AutomatonException "Error on #DIV not a int i");
            );

        | OPSUB -> (
          let x = (Stack.pop valueStack) in
            match x with
              | Int(i) -> (
                let y = (Stack.pop valueStack) in
                match y with
                  | Int(j) -> (
                    (Stack.push (Int(j - i)) valueStack);
                  );
                  | _ -> raise (AutomatonException "Error on #SUB not a int j");
              );
              | _ -> raise (AutomatonException "Error on #SUB not a int i");
            );

        | OPEQ -> (
          let x = (Stack.pop valueStack) in
            match x with
              | Bool(i) -> (
                let y = (Stack.pop valueStack) in
                match y with
                  | Bool(j) -> (
                    (Stack.push (Bool(i == j)) valueStack);
                  );
                  | _ -> raise (AutomatonException "Error on #EQ not a bool j");
              );
              | Int(i) -> (
                let y = (Stack.pop valueStack) in
                match y with
                  | Int(j) -> (
                    (Stack.push ( Bool ( i == j)) valueStack);
                  );
                  | _ -> raise (AutomatonException "Error on #EQ not a bool j");
              );
              | _ -> raise (AutomatonException "Error on #EQ not a bool i");
            );

        | OPAND -> (
          let x = (Stack.pop valueStack) in
            match x with
              | Bool(i) -> (
                let y = (Stack.pop valueStack) in
                match y with
                  | Bool(j) -> (
                    (Stack.push (Bool(i && j)) valueStack);
                  );
                  | _ -> raise (AutomatonException "Error on #AND not a bool j");
              );
              | _ -> raise (AutomatonException "Error on #AND not a bool i");
            );

        | OPOR -> (
          let x = (Stack.pop valueStack) in
            match x with
              | Bool(i) -> (
                let y = (Stack.pop valueStack) in
                match y with
                  | Bool(j) -> (
                    (Stack.push (Bool(i || j)) valueStack);
                  );
                  | _ -> raise (AutomatonException "Error on #OR not a bool j");
              );
              | _ -> raise (AutomatonException "Error on #OR not a bool i");
            );

        | OPLT -> (
          let x = (Stack.pop valueStack) in
            match x with
              | Int(i) -> (
                let y = (Stack.pop valueStack) in
                match y with
                  | Int(j) -> (
                    (Stack.push ( Bool ( j < i)) valueStack);
                  );
                  | _ -> raise (AutomatonException "Error on #LT not a int j");
              );
              | _ -> raise (AutomatonException "Error on #LT not a int i");
            );

        | OPLE -> (
          let x = (Stack.pop valueStack) in
            match x with
              | Int(i) -> (
                let y = (Stack.pop valueStack) in
                match y with
                  | Int(j) -> (
                    (Stack.push ( Bool ( j <= i)) valueStack);
                  );
                  | _ -> raise (AutomatonException "Error on #LE not a int j");
              );
              | _ -> raise (AutomatonException "Error on #LE not a int i");
            );

        | OPGT -> (
          let x = (Stack.pop valueStack) in
            match x with
              | Int(i) -> (
                let y = (Stack.pop valueStack) in
                match y with
                  | Int(j) -> (
                    (Stack.push ( Bool ( j > i)) valueStack);
                  );
                  | _ -> raise (AutomatonException "Error on #GT not a int j");
              );
              | _ -> raise (AutomatonException "Error on #GT not a int i");
            );

        | OPGE -> (
          let x = (Stack.pop valueStack) in
            match x with
              | Int(i) -> (
                let y = (Stack.pop valueStack) in
                match y with
                  | Int(j) -> (
                    (Stack.push ( Bool ( j >= i)) valueStack);    
                  );
                  | _ -> raise (AutomatonException "Error on #GE not a int j");
              );
              | _ -> raise (AutomatonException "Error on #GE not a int i");
            );

        | OPNOT -> (
          let x = (Stack.pop valueStack) in
            match x with
              | Bool(i) -> (
                (Stack.push (Bool(not(i))) valueStack);
              );
              | _ -> raise (AutomatonException "Error on #NOT not a bool i");
            );                                                                     
      );

      | CmdOc(cmdOc) -> (
        match cmdOc with 
        | OPASSIGN -> (
          let value = (Stack.pop valueStack) in
            let id = (Stack.pop valueStack) in 
              match id with 
              | Str(x) -> (
                let env = (Hashtbl.find environment x ) in
                  match env with 
                  | Loc(Location(l)) -> (
                    match value with
                    | Int(i) -> (
                      (Hashtbl.replace memory l (Integer(i)));
                    );
                    | Bool(b) -> (
                      (Hashtbl.replace memory l (Boolean(b)));
                    );
                    | Bind(b) -> (
                      (Hashtbl.replace memory l (Pointer(b)));
                    );
                    | _ -> raise (AutomatonException "Error on #ASSIGN")
                  ); 
                  | IntConst(i) -> (
                    raise (AutomatonException "Error on #ASSIGN. Cannot change constant value.")
                  ); 
                  | BoolConst(b) -> (
                    raise (AutomatonException "Error on #ASSIGN. Cannot change constant value.")
                  );
                  | _ -> ();
              );
              | _ ->  raise (AutomatonException "Error on #ASSIGN not a str(x)")
        );

        | OPLOOP -> (
          let condloop = (Stack.pop valueStack) in 
            let loopV = (Stack.pop valueStack) in
            match condloop with
              | Bool(true) -> (
                match loopV with
                  | LoopValue(Loop(x,m)) -> (
                    (Stack.push (Statement(Cmd(Loop(x,m)))) controlStack);
                    (Stack.push (Statement(Cmd(m))) controlStack);
                  )
                  | _ -> raise (AutomatonException "Error on #LOOP invalid loop sintaxe loop(x,m)");
              );
              | Bool(false) -> ();  (* Não faz nada já que o pop foi feito antes *)
              | _ -> raise (AutomatonException "Error on #LOOP sintaxe error")
        );

        | OPCOND -> (
          let ifcond = (Stack.pop valueStack) in
            let condV = (Stack.pop valueStack) in
            match ifcond with
              | Bool(condition) -> (
                match condV with
                  | CondValue(Cond(x,m1,m2)) ->(
                    if condition then
                    (Stack.push (Statement(Cmd(m1))) controlStack)
                    else
                    (Stack.push (Statement(Cmd(m2))) controlStack);
                  )
                  | _ -> raise (AutomatonException "Error on #COND");
              );
              | _ -> raise (AutomatonException "Error on #COND" );
        );
        | OPCALL(Id(x), n) -> (
          let fnc = (Hashtbl.find environment x) in
          let actuals = (List.rev (n_pop valueStack n)) in
          let env = (Hashtbl.copy environment) in        
          (Stack.push (Locations(!locations)) valueStack);
          locations := [];
        
          (Stack.push (Env(env)) valueStack);
          (Stack.push (DecOc(OPBLKCMD)) controlStack);

          match fnc with 
          | Closure(f, b, e_1) -> (

                (Stack.push (Statement(Cmd(b))) controlStack);
                let e_barra_e1 = (overwrite (Hashtbl.copy environment) e_1) in
                let result_barra_match = (overwrite e_barra_e1 (matchFunction f actuals)) in
                (Hashtbl.clear environment);
                (Hashtbl.add_seq environment (Hashtbl.to_seq result_barra_match));
          );
          | Rec(f, b, e_1, e_2) -> (

            (Stack.push (Statement(Cmd(b))) controlStack);
            let e_barra_e1 = (overwrite (Hashtbl.copy environment) e_1) in
            let result_barra_unfold =  (overwrite e_barra_e1 (reclose e_2 environment)) in
            let result_barra_match = (overwrite result_barra_unfold (matchFunction f actuals)) in
            (Hashtbl.clear environment);
            (Hashtbl.add_seq environment (Hashtbl.to_seq result_barra_match));
          );
          | _ -> raise (AutomatonException "Error on #CALL" );
        );
        | _ -> ();
      );

      | DecOc(decOc) -> (
        match decOc with
        | OPREF -> (
          let loc = (List.length !trace) in
          let value = (Stack.pop valueStack) in
          (Stack.push (Bind((Location(loc)))) valueStack);
          locations := (!locations)@[loc];
          match value with
          | Int(x) -> (
            (Hashtbl.add  memory loc (Integer(x)));
          );
          | Bool(x) -> (
            (Hashtbl.add  memory (loc) (Boolean(x)));
          );
          | Bind(x) -> (
            (Hashtbl.add  memory (loc) (Pointer(x)));
          );
          | _  -> raise (AutomatonException "Error on #REF" );
        );
        
        | OPBIND -> (
          let l = (Stack.pop valueStack) in
            let id = (Stack.pop valueStack) in
            match id with 
            |Str(w) -> (
              match (Stack.top valueStack) with
              |Env(h) -> (
                match (Stack.pop valueStack) with 
                | Env (env) -> (                                   (*env exists *)  
                    let newEnv = (Hashtbl.copy env) in
                    match l with 
                    |Bind(y)   -> ( ( Hashtbl.add newEnv w (Loc(y)) );
                                    ( Stack.push (Env(newEnv)) valueStack ); 
                    );
                    |Int(cte)  -> ( ( Hashtbl.add newEnv w (IntConst(cte)) );
                                    ( Stack.push (Env(newEnv)) valueStack ); 
                    );                   
                    |Bool(cte) -> ( ( Hashtbl.add newEnv w (BoolConst(cte)) );
                                    ( Stack.push (Env(newEnv)) valueStack ); 
                    );  
                    |Clos(f, b, e) -> ( ( Hashtbl.add newEnv w (Closure(f, b, e)) );
                                    ( Stack.push (Env(newEnv)) valueStack ); 
                    );                   
                    | _ -> raise (AutomatonException "Error on #BIND valor not binded" );
                );
                | _ -> raise (AutomatonException "Error on #BIND env not found" );
              );
              |_ -> (   let newEnv = (Hashtbl.create 3) in            (*1st dec of block*)
                        match l with 
                        |Bind(y)   -> (( Hashtbl.add newEnv w (Loc(y)) );
                                       ( Stack.push (Env(newEnv)) valueStack );
                        );
                        |Int(cte)  -> (( Hashtbl.add newEnv w (IntConst(cte)) );
                                       ( Stack.push (Env(newEnv)) valueStack );
                        );
                        |Bool(cte) -> (( Hashtbl.add newEnv w (BoolConst(cte)) );
                                       ( Stack.push (Env(newEnv)) valueStack );
                        ); 
                        | Clos(f, b, e) -> ( ( Hashtbl.add newEnv w (Closure(f, b, e)) );
                        ( Stack.push (Env(newEnv)) valueStack ); 
        );                       
                        | _ -> raise (AutomatonException "Error on #BIND map not created" );
              );
            );
            | _ -> raise (AutomatonException "Error on #BIND not a valid ID" );
          );
          | OPBLKDEC -> (
            let ass = (Stack.pop valueStack) in
              let env = Hashtbl.copy environment in
                match ass with
                  | Env(e) -> (
                    (Stack.push (Env(env)) valueStack);
                    let new_env = (overwrite environment e) in
                    (Hashtbl.clear environment);
                    (Hashtbl.add_seq environment (Hashtbl.to_seq new_env));
                  );
                  | _ -> raise (AutomatonException "Error on #BLKDEC" );
          );

          | OPBLKCMD -> (
            let env = (Stack.pop valueStack) in
              let locs = (Stack.pop valueStack) in
                match env with 
                  | Env(y) -> (
                    match locs with 
                      | Locations(x) -> (
                        (Hashtbl.clear environment);
                        (Hashtbl.add_seq environment (Hashtbl.to_seq y));
                        (
                          Hashtbl.iter 
                          (  
                            fun key value -> 
                              if (List.mem key !locations) 
                              then (Hashtbl.remove memory key) 
                          ) 
                          memory 
                        );
                        locations := x;
                      );
                      | _ -> ();
                  );
                  | _ -> raise (AutomatonException "Error on #BLKCMD" );
          );
      );
    );
    delta controlStack valueStack environment memory locations;
  end

  and n_pop stack n = 
  if (n == 0) then []
  else [(Stack.pop stack)]@(n_pop stack (n-1))

  and overwrite old_environment new_environment = 
    let old = (Hashtbl.copy old_environment) in
    (
      Hashtbl.iter 
      (
        fun key value -> 
          if not(Hashtbl.mem old key ) then 
            (Hashtbl.add old key value) 
          else (Hashtbl.replace old key value) 
      ) 
      new_environment
    );
    old;
  
  and matchFunction formals actuals = 
    if ((List.length formals) != (List.length actuals)) then (Hashtbl.create 0)
    else (_match formals actuals (Hashtbl.create 10))
  
  (* Recebe duas listas de tamanho igual *)
  and _match formals actuals env = 
    match formals, actuals with
    | [], [] -> env;
    | Id(f)::ftl, ahd::atl -> (
      let newEnv = (_match ftl atl env) in
      match ahd with
      | Int(i) -> (
        (Hashtbl.add newEnv f (IntConst(i)));
        newEnv;
      );
      | Bool(b) ->  (
        (Hashtbl.add newEnv f (BoolConst(b)));
        newEnv;
      );
    )

  and reclose env atual = 
  (Hashtbl.iter 
    (
      fun key value -> 
        match value with
        | Closure(f, b, e) -> (
         ( Hashtbl.replace env key (Rec(f, b, e, atual) ) );
        );
        | Rec(f, b, e, e_line) -> (
          ( Hashtbl.replace env key (Rec(f, b, e, atual) ) );
         );
        | _ -> ();
    )
   env);
  env;;

