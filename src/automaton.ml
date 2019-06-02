open Util;;
open Pi;;
open AutomatonType;;

let trace = ref [];;


let rec delta controlStack valueStack environment memory locations = 
  
  let copia = !locations in
  trace := (!trace)@[( (Stack.copy controlStack), (Stack.copy valueStack), (Hashtbl.copy environment), (Hashtbl.copy memory), (copia))];
  
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
                (* | Value(x) -> (); *)
                | Loc(x) -> (
                  let value = Hashtbl.find memory x  in
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
              | Sum(_, _) -> raise (AutomatonException "Error on Sum"); 
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
              | Or(_, _) -> raise (AutomatonException "Error on Or");
              | Not(BExp(x)) -> (
                (Stack.push (ExpOc(OPNOT)) controlStack);
                (Stack.push (Statement(Exp(BExp(x)))) controlStack);
                
              );
              | Not(Id(x)) -> (
                (Stack.push (ExpOc(OPNOT)) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
                
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
                    (Stack.push (Bind(Loc(x))) valueStack );
                  )
                  | _ -> raise (AutomatonException "Error on DeRef 1");
              );
              | _ -> raise (AutomatonException "Error on DeRef 2");
            );
            | ValRef(ref) -> (
              match ref with
              | Id(id) -> (
                let key = Hashtbl.find environment id  in
                match key with 
                  | Loc(x1) -> (
                    let value1 = Hashtbl.find memory x1  in
                      match value1 with
                      | Integer(x2) ->   raise (AutomatonException "Error on ValRef: Integer encontrado!");
                      | Boolean(x2) ->  raise (AutomatonException "Error on ValRef - Boolean encontrado!");
                      | Pointer(x2) -> (
                        match x2 with
                        | Loc(x3) -> (
                          let value2 = Hashtbl.find memory x3  in
                          match value2 with
                          | Integer(x4) ->   (Stack.push (Int(x4)) valueStack);
                          | Boolean(x4) ->  (Stack.push (Bool(x4)) valueStack);
                          | Pointer(x4) -> raise (AutomatonException "Error on ValRef");
                        );
                      );
                  )
              );

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
          | Cond(_, _, _) -> raise (AutomatonException "Error on Cond");
          | Blk(x, y) -> (
            (Stack.push (DecOc(OPBLKCMD)) controlStack);
            (Stack.push (Statement(Cmd(y))) controlStack);
            (Stack.push (DecOc(OPBLKDEC)) controlStack);
            (Stack.push (Statement(Dec(x))) controlStack);

            let new_locations = !locations in (Stack.push (List(new_locations)) valueStack);
            locations := [] ;
          );
          | Nop -> ();
        );
        | Dec (dec) -> (
          match dec with 
          | Bind(Id(x), y) -> (
            (Stack.push (DecOc(OPBIND)) controlStack );
            (Stack.push (Statement(Exp(y))) controlStack );
            (Stack.push (Str(x)) valueStack);
         );
          | _ -> ();
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
                  | _ -> raise (AutomatonException "Error on #SUM");
              );
              | _ -> raise (AutomatonException "Error on #SUM");
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
                  | _ -> raise (AutomatonException "Error on #MUL");
              );
              | _ -> raise (AutomatonException "Error on #MUL");
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
                  | _ -> raise (AutomatonException "Error on #DIV");
              );
              | _ -> raise (AutomatonException "Error on #DIV");
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
                  | _ -> raise (AutomatonException "Error on #SUB");
              );
              | _ -> raise (AutomatonException "Error on #SUB");
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
                  | _ -> raise (AutomatonException "Error on #EQ");
              );
              | Int(i) -> (
                let y = (Stack.pop valueStack) in
                match y with
                  | Int(j) -> (
                    (Stack.push ( Bool ( i == j)) valueStack);
                    
                  );
                  | _ -> raise (AutomatonException "Error on #EQ");
              );
              | _ -> raise (AutomatonException "Error on #EQ");
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
                  | _ -> raise (AutomatonException "Error on #AND");
              );
              | _ -> raise (AutomatonException "Error on #AND");
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
                  | _ -> raise (AutomatonException "Error on #OR");
              );
              | _ -> raise (AutomatonException "Error on #OR");
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
                  | _ -> raise (AutomatonException "Error on #LT");
              );
              | _ -> raise (AutomatonException "Error on #LT");
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
                  | _ -> raise (AutomatonException "Error on #LE");
              );
              | _ -> raise (AutomatonException "Error on #LE");
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
                  | _ -> raise (AutomatonException "Error on #GT");
              );
              | _ -> raise (AutomatonException "Error on #GT");
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
                  | _ -> raise (AutomatonException "Error on #GE");
              );
              | _ -> raise (AutomatonException "Error on #GE");
            );
        | OPNOT -> (
          let x = (Stack.pop valueStack) in
            match x with
              | Bool(i) -> (
                (Stack.push (Bool(not(i))) valueStack);
              );
              
              | _ -> raise (AutomatonException "Error on #NOT");
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
                  | Loc(l) -> (
                    match value with
                    | Int(i) -> (
                      (Hashtbl.replace memory l (Integer(i)));
                    );
                    | Bool(b) -> (
                      (Hashtbl.replace memory l (Boolean(b)));
                    );
                    | _ -> raise (AutomatonException "Error on #ASSIGN")
                    
                  );
                  (* | Value(v) -> (

                  ); *)
                  
              );
              | _ -> raise (AutomatonException "Error on #ASSIGN")
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
                  | _ -> raise (AutomatonException "Error on #LOOP");
              );
              | Bool(false) -> ();  (* Não faz nada já que o pop foi feito antes *)
              | _ -> raise (AutomatonException "Error on #LOOP")
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
      );
      | DecOc(decOc) -> (
        match decOc with
        | OPREF -> (
          let loc = (List.length !trace) in
          let value = (Stack.pop valueStack) in
          match value with
          | Int(x) -> (
            (Hashtbl.add  memory loc (Integer(x)));
            (Stack.push (Bind(Loc(loc))) valueStack);
            locations := (!locations)@[loc];
          );
          | Bool(x) -> (
            (Hashtbl.add  memory (loc) (Boolean(x)));
            (Stack.push (Bind(Loc(loc))) valueStack);
            locations := (!locations)@[loc];
          );
          | Str(x) -> ();
          | LoopValue(x) -> ();
          | CondValue(x) -> ();
          | Assoc(x, y) ->  ();
          | Bind(x) -> ();
        );
        | OPBIND -> (
          let l = (Stack.pop valueStack) in
            let id = (Stack.pop valueStack) in
              match id with
              | Str(x) ->(
                match l with
                  | Bind(Loc(y)) -> (
                    (Stack.push (Assoc(x,Loc(y))) valueStack);
                  );
                  | _ -> raise (AutomatonException "Error on #OPBIND 1" );
              );
              | _ -> raise (AutomatonException "Error on #OPBIND 2" );
          );
          | OPBLKDEC -> (
            let ass = (Stack.pop valueStack) in
              let env = Hashtbl.copy environment in
                match ass with
                  | Assoc(x, y) -> (
                    (Stack.push (Env(env)) valueStack);
                    (*Precisa aqui fazer a matemática de quem permanece no 
                    environment e quem sai...*)
              );
          );
          | OPBLKCMD -> (
            let env = (Stack.pop valueStack) in
              let locs = (Stack.pop valueStack) in
                match locs with
                  | List(x) -> (
                    locations := x;
                    match env with
                      | Env(y) -> (
                        environment := y;
                      );
                  );
                (*Precisa aqui fazer a matemática de quem permanece na 
                    memória e quem sai...*)
          );

      );
    );
    delta controlStack valueStack environment memory locations;
  end;;