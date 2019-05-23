# P1 Compiladores


#Demonstração em código das denotações

No autômato, o nosso código inicia-se com um POP na pilha de controle, e logo em seguida faz-se o seguinte PATTERN MATCH, para tomar a devida decisão de acordo com o elemento que se retirou, podendo ele ser algum tipo indutivo de Pi ou algum OPTCODE.


Quando lê-se um NUM(N), simplesmente colocamos o valor N na pilha de valores.


```
_δ(Num(N) :: C, V, S) = δ(C, N :: V, S)_  

```

```
Num(x) -> (
                (Stack.push (Int(x)) valueStack);
                );
```

Quando lê-se um SUM(E1, E2), devemos antes verificar a qual tipo pertencem os dois parâmetros de Expression (Arithmetic Expression ou ID(x)) podendo haver a combinação 2 a 2 deles. Por exemplo, podemos fazer os 4 tipos de soma: 2 + 2; 2 + x; x + 2; x + y;

Para cada um desses casos, agimos da mesma forma: colocamos primeiro o OPTCODE #SUM, depois a Expressão Y e por fim a Expressão X na pilha de valores.


_δ(Sum(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #SUM :: C, V, S)_   


```
Sum(AExp(x), AExp(y)) -> (
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
```

Ao ler o #SUM, fazemos um pop para ler o valor X e depois outro para ler o valor Y, logo após verificamos que ambos são do tipo inteiro e somamos eles, colocando o resultado na pilha de valores. Caso não sejam, cairíamos em uma Exception.

_δ(#SUM :: C, Num(N₁) :: Num(N₂) :: V, S) = δ(C, N₁ + N₂ :: V, S)_


```
OPSUM -> (
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
```

_δ(Sub(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #SUB :: C, V, S)_  


```
Sub(AExp(x), AExp(y)) -> (
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
```

_δ(#SUB :: C, Num(N₁) :: Num(N₂) :: V, S) = δ(C, N₁ - N₂ :: V, S)_

```            
OPSUB -> (
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
```            

_δ(Mul(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #MUL :: C, V, S)_  

```            
Mul(AExp(x), AExp(y)) -> (
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
```

_δ(#MUL :: C, Num(N₁) :: Num(N₂) :: V, S) = δ(C, N₁ * N₂ :: V, S)_

```
OPMUL -> (
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
```

_δ(Div(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #DIV :: C, V, S)_  

```              
Div(AExp(x), AExp(y)) -> (
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
```

_δ(#DIV :: C, Num(N₁) :: Num(N₂) :: V, S) = δ(C, N₁ / N₂ :: V, S) if N₂ ≠ 0_

```
OPDIV -> (
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
```

_δ(Eq(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #EQ :: C, V, S)_

```
Eq(BExp(x), BExp(y)) -> (
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
```

_δ(#EQ :: C, Boo(B₁) :: Boo(B₂) :: V, S) = δ(C, B₁ = B₂ :: V, S)_

```
OPEQ -> (
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
```

_δ(Lt(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #LT :: C, V, S)_

```
Lt(AExp(x), AExp(y)) -> (
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
```

_δ(#LT :: C, Num(N₁) :: Num(N₂) :: V, S) = δ(C, N₁ < N₂ :: V, S)_

```
OPLT -> (
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
```

_δ(Le(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #LE :: C, V, S)_

```
Le(AExp(x), AExp(y)) -> (
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
```

_δ(#LE :: C, Num(N₁) :: Num(N₂) :: V, S) = δ(C, N₁ ≤ N₂ :: V, S)_

```
OPLE -> (
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
```

_δ(Gt(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #GT :: C, V, S)_

```
Gt(AExp(x), AExp(y)) -> (
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
```

_δ(#GT :: C, Num(N₁) :: Num(N₂) :: V, S) = δ(C, N₁ > N₂ :: V, S)_


```
OPGT -> (
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
```

_δ(Ge(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #GE :: C, V, S)_

```
Ge(AExp(x), AExp(y)) -> (
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
```

_δ(#GE :: C, Num(N₁) :: Num(N₂) :: V, S) = δ(C, N₁ ≥ N₂ :: V, S)_

```
OPGE -> (
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
```

_δ(And(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #AND :: C, V, S)_

```
And(BExp(x), BExp(y)) -> (
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
```

_δ(#AND :: C, Boo(B₁) :: Boo(B₂) :: V, S) = δ(C, B₁ ∧ B₂ :: V, S)_

```
OPAND -> (
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
```

_δ(Or(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #OR :: C, V, S)_

```
Or(BExp(x), BExp(y)) -> (
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
```

_δ(#OR :: C, Boo(B₁) :: Boo(B₂) :: V, S) = δ(C, B₁ ∨ B₂ :: V, S)_

```
OPOR -> (
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
```

_δ(Not(E) :: C, V, S) = δ(E :: #NOT :: C, V, S)_

```
Not(BExp(x)) -> (
                (Stack.push (ExpOc(OPNOT)) controlStack);
                (Stack.push (Statement(Exp(BExp(x)))) controlStack); 
              );
| Not(Id(x)) -> (
                (Stack.push (ExpOc(OPNOT)) controlStack);
                (Stack.push (Statement(Exp(Id(x)))) controlStack);
              );
```

_δ(#NOT :: C, Boo(True) :: V, S) = δ(C, False :: V, S)_
_δ(#NOT :: C, Boo(False) :: V, S) = δ(C, True :: V, S)_

```
OPNOT -> (
          let x = (Stack.pop valueStack) in
            match x with
              | Bool(i) -> (
                (Stack.push (Bool(not(i))) valueStack);
              );
              
              | _ -> raise (AutomatonException "Error on #NOT");
            );   
```

_δ(Id(W) :: C, V, E, S) = δ(C, B :: V, E, S), where E[W] = l ∧ S[l] = B_

```
Id(id) -> (
            let key = Hashtbl.find environment id  in
              match key with 
                | Value(x) -> ();
                | Loc(x) -> (
                  let value = Hashtbl.find memory x  in
                    match value with
                    | Integer(x) ->   (Stack.push (Int(x)) valueStack);
                    | Boolean(x) ->  (Stack.push (Bool(x)) valueStack);
                )
            );
```

_δ(Assign(W, X) :: C, V, E, S) = δ(X :: #ASSIGN :: C, W :: V, E, S')_

```
Assign(Id(x), y) -> (
             (Stack.push (CmdOc(OPASSIGN)) controlStack );
             (Stack.push (Statement(Exp(y))) controlStack );
             (Stack.push (Str(x)) valueStack);
          );
```

_δ(#ASSIGN :: C, T :: W :: V, E, S) = δ(C, V, E, S'), where E[W] = l ∧ S' = S/[l ↦ T]_

```
OPASSIGN -> (
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
                  | Value(v) -> (

                  );
                  
              );
              | _ -> raise (AutomatonException "Error on #ASSIGN")
            );
```

_δ(Loop(X, M) :: C, V, E, S) = δ(X :: #LOOP :: C, Loop(X, M) :: V, E, S)_

```
Loop( BExp(x), y) -> (
            (Stack.push (CmdOc(OPLOOP)) controlStack);
            (Stack.push (Statement(Exp(BExp(x)))) controlStack );
            (Stack.push (Control(Statement(Cmd(Loop(BExp(x), y))))) valueStack ); 
          );
| Loop(Id(x), y) -> (
            (Stack.push (CmdOc(OPLOOP)) controlStack);
            (Stack.push (Statement(Exp(Id(x)))) controlStack );
            (Stack.push (Control(Statement(Cmd(Loop(Id(x), y))))) valueStack );
          );
```

_δ(#LOOP :: C, Boo(true) :: Loop(X, M) :: V, E, S) = δ(M :: Loop(X, M) :: C, V, E, S)_
_δ(#LOOP :: C, Boo(false) :: Loop(X, M) :: V, E, S) = δ(C, V, E, S)_

```
OPLOOP -> (
          let condloop = (Stack.pop valueStack) in 
            let loopV = (Stack.pop valueStack) in
            match condloop with
              | Bool(true) -> (
                match loopV with
                  | Control(Statement(Cmd(Loop(x,m)))) -> (

                    (Stack.push (Statement(Cmd(Loop(x,m)))) controlStack);
                    (Stack.push (Statement(Cmd(m))) controlStack);
                    
                  )
                  | _ -> raise (AutomatonException "Error on #LOOP");
              );
              | Bool(false) -> ();  (* Não faz nada já que o pop foi feito antes *)
              | _ -> raise (AutomatonException "Error on #LOOP")
        );
```

_δ(Cond(X, M₁, M₂) :: C, V, E, S) = δ(X :: #COND :: C, Cond(X, M₁, M₂) :: V, E, S)_

```
Cond(BExp(x), y, z) -> (
            (Stack.push (CmdOc(OPCOND)) controlStack);
            (Stack.push (Statement(Exp(BExp(x)))) controlStack );
            (Stack.push (Control(Statement(Cmd(Cond(BExp(x), y, z))))) valueStack );
          );
| Cond(Id(x), y, z) -> (
            (Stack.push (CmdOc(OPCOND)) controlStack);
            (Stack.push (Statement(Exp(Id(x)))) controlStack );
            (Stack.push (Control(Statement(Cmd(Cond(Id(x), y, z))))) valueStack );
          );
```

_δ(#COND :: C, Boo(true) :: Cond(X, M₁, M₂) :: V, E, S) = δ(M₁ :: C, V, E, S)_
_δ(#COND :: C, Boo(false) :: Cond(X, M₁, M₂) :: V, E, S) = δ(M₂ :: C, V, E, S)_

```
OPCOND -> (
          let ifcond = (Stack.pop valueStack) in
            let condV = (Stack.pop valueStack) in
            match ifcond with
              | Bool(condition) -> (
                match condV with
                  | Control(Statement(Cmd(Cond(x,m1,m2)))) ->(
                    if condition then
                    (Stack.push (Statement(Cmd(m1))) controlStack)
                    else
                    (Stack.push (Statement(Cmd(m2))) controlStack);
                  )
                  | _ -> raise (AutomatonException "Error on #COND");
              );
              | _ -> raise (AutomatonException "Error on #COND" );
        );
```

_δ(CSeq(M₁, M₂) :: C, V, E, S) = δ(M₁ :: M₂ :: C, V, E, S)_

```
CSeq(x, y) -> (
            (Stack.push (Statement(Cmd(y))) controlStack );
            (Stack.push (Statement(Cmd(x))) controlStack );
          );
```
