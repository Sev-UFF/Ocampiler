# P1 Compiladores

Em cada tópico a seguir explicaremos como implementamos o funcionamento do π framework em Ocaml.


## Gramática π



## Lexer

De acordo com as especificações da linguagem, criamos tokens para cada estrutura definida pela lingugagem no processo de análise sintática.
Usamos a implementação em Ocaml do programa lex, o Ocamllex, definido em um arquivo .mll. Com ele definimos uma expressão regular para cada token que queremos identificar. O retorno da função do lexer é uma lista dos tokens que definimos. A declaração de cada token fica no arquivo que define as estruturas do parser, explicado logo a seguir, no arquivo do lexer importamos o parser para termos acesso a esses tokens. 

Vamos ilustrar o processo do lexer com um exemplo. Dado o código fonte imp 

```
x := x + 1
```

Vemos a definição dos tokens que serão usados nesse caso

```
  %token <int> NUMBER
  %token <string> ID
  %token PLUS 
  %token ASSIGN
```

E também as expressões regulares que identificam e retornam cada um desses tokens

```
rule token = parse
    [' ' '\t' '\r' '\n'  ]   { token lexbuf }     (* skip blanks *)
  | (['-']? ['0'-'9']+) as  lxm      { NUMBER( int_of_string lxm) }
  | '+'                     { PLUS }
  | ":="                    { ASSIGN }
  | (['a'-'z' 'A'-'Z' '_'] ['a'-'z' 'A'-'Z' '0'-'9' '_']*) as  lxm      { ID(lxm) }
  | eof                     { EOF }
```

No nosso exemplo então a lista de tokens referente ao código de entrada em imp é

```
ID(x) ASSIGN ID(x) SUM NUMBER(1)
```


## Parser

O parser, Ocamlyacc é a implementação de Ocaml do programa yacc, definido em um arquivo mly. Ele deve analisar a estrutura do programa sendo o nosso analisador semântico. Para implementarmos o π framework, de acordo com a leitura de tokens específicas feita, retornamos a denotação π associada àquela operação. O programa é uma tabela de tokens estruturados similares às expressões regulares definidas no lexer. O parser recebe a lista de tokens associada ao programa de entrada e analisa qual estrutura definida em sua tabela corresponde à primeira correspondência lida nessa lista. 

A tabela definida no arquivo do parser tem algumas restrições. Primeiro ela deve retornar um tipo único, no nosso caso a π denotação que englobe todas as outras, _statement_. Definimos todos os tipos definidos da gramática também no parser para a melhor estruturação da leitura dos tokens. 

Temos então a definição dos tipos das π denotações no nível do parser

```
%type <Pi.statement> main
%type <Pi.statement> statement
%type <Pi.expression> expression
%type <Pi.arithmeticExpression> arithmeticExpression
%type <Pi.booleanExpression> booleanExpression
%type <Pi.command> command
```

Onde criamos o tipo main como tipo de retorno da função

```
%%
main:
    statement EOF     { $1 }
;
```

Para cada tipo definido então definimos a estrutura de tokens associado a ele que está de acordo com as especificações da linguagem. Cada tipo pode retornar outros tipos, ou diretamente uma π denotação, o parser funciona como um todo então através da recursão. Os tipos mantém a mesma hierarquia do π framework e da linguagem.

```
 statement:
  expression { Pi.Exp($1)}
  | command      {Pi.Cmd($1)}
;

 command:
  ID ASSIGN expression                        { Pi.Assign(Pi.Id($1), $3) }
;

expression: 
    arithmeticExpression                    { Pi.AExp( $1) }
    | booleanExpression                     { Pi.BExp( $1) }
    | ID                                    { Pi.Id( $1) } 
;

arithmeticExpression:  
  NUMBER                                              { Pi.Num($1) }
  | arithmeticExpression PLUS arithmeticExpression    { Pi.Sum(Pi.AExp($1), Pi.AExp($3) )  }
  | arithmeticExpression PLUS ID                      { Pi.Sum(Pi.AExp($1), Pi.Id($3) )  }
  | ID PLUS arithmeticExpression                      { Pi.Sum(Pi.Id($1), Pi.AExp($3) )  }
  | ID PLUS ID                                        { Pi.Sum(Pi.Id($1), Pi.Id($3) )  }
;
```

De acordo com a estruturação feita, ao lermos o token NUMBER, iremos cair no caso em que retornamos a denotação Num, que por sua vez, graças a recursão de tipos é englobada dentro do tipo arithmeticExpression, que engloba a denotação Num na denotação AExp, até chegarmos no tipo definido pela main. 

Com o exemplo mostrado podemos fazer o parse da lista de tokens mostrada no último tópico que será

```
Assign(Id(x), Sum(Id(x), Num(1)))
```



## Autômato π 

No autômato, o nosso código inicia-se com um POP na pilha de controle, e logo em seguida faz-se o seguinte PATTERN MATCH, para tomar a devida decisão de acordo com o elemento que se retirou, podendo ele ser algum tipo indutivo de Pi ou algum OPTCODE.


Quando lê-se um NUM(N), simplesmente colocamos o valor N na pilha de valores.


```
δ(Num(N) :: C, V, S) = δ(C, N :: V, S) 
```

```
Num(x) -> 
(
  (Stack.push (Int(x)) valueStack);
);
```

Quando lê-se um SUM(E1, E2), devemos antes verificar a qual tipo pertencem os dois parâmetros de Expression (Arithmetic Expression ou ID(x)) podendo haver a combinação 2 a 2 deles. Por exemplo, podemos fazer os 4 tipos de soma: 2 + 2; 2 + x; x + 2; x + y;

Para cada um desses casos, agimos da mesma forma: colocamos primeiro o OPTCODE #SUM, depois o E2 (Arithmetic Expression Y) e por fim o E1 (Arithmetic Expression X) na pilha de valores.


```
δ(Sum(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #SUM :: C, V, S) 
```

```
Sum(AExp(x), AExp(y)) -> 
(
  (Stack.push (ExpOc(OPSUM)) controlStack);
  (Stack.push (Statement(Exp(AExp(y)))) controlStack);
  (Stack.push (Statement(Exp(AExp(x)))) controlStack);
);
| Sum(Id(x), AExp(y)) -> 
(
  (Stack.push (ExpOc(OPSUM)) controlStack);
  (Stack.push (Statement(Exp(AExp(y)))) controlStack);
  (Stack.push (Statement(Exp(Id(x)))) controlStack);
); 
| Sum(AExp(x), Id(y)) ->  
(
  (Stack.push (ExpOc(OPSUM)) controlStack);
  (Stack.push (Statement(Exp(Id(y)))) controlStack);
  (Stack.push (Statement(Exp(AExp(x)))) controlStack);
); 
| Sum(Id(x), Id(y)) ->  
(
  (Stack.push (ExpOc(OPSUM)) controlStack);
  (Stack.push (Statement(Exp(Id(y)))) controlStack);
  (Stack.push (Statement(Exp(Id(x)))) controlStack);
);
```

Ao ler o #SUM, fazemos um pop na pilha de valores para ler o valor X(N1) e verificamos que é do tipo inteiro. Depois fazemos outro POP para ler o valor Y(N2) e verificamos que este também é do tipo inteiro. Depois somamos eles, colocando o resultado na pilha de valores. Caso não sejam, cairíamos em uma Exception.

```
δ(#SUM :: C, Num(N₁) :: Num(N₂) :: V, S) = δ(C, N₁ + N₂ :: V, S)
```

```
OPSUM -> 
(
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

Quando lê-se um SUB(E1, E2), devemos antes verificar a qual tipo pertencem os dois parâmetros de Expression (Arithmetic Expression ou ID(x)) podendo haver a combinação 2 a 2 deles. Por exemplo, podemos fazer os 4 tipos de subtração: 4 - 4; 4 - x; x - 4; x - y;

Para cada um desses casos, agimos da mesma forma: colocamos primeiro o OPTCODE #SUB, depois o E2 (Arithmetic Expression Y) e por fim o E1 (Arithmetic Expression X) na pilha de valores.

```
δ(Sub(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #SUB :: C, V, S)  
```

```
Sub(AExp(x), AExp(y)) -> 
(
  (Stack.push (ExpOc(OPSUB)) controlStack);
  (Stack.push (Statement(Exp(AExp(y)))) controlStack);
  (Stack.push (Statement(Exp(AExp(x)))) controlStack);
);
| Sub(Id(x), AExp(y)) -> 
(
  (Stack.push (ExpOc(OPSUB)) controlStack);
  (Stack.push (Statement(Exp(AExp(y)))) controlStack);
  (Stack.push (Statement(Exp(Id(x)))) controlStack);
); 
| Sub(AExp(x), Id(y)) ->  
(
  (Stack.push (ExpOc(OPSUB)) controlStack);
  (Stack.push (Statement(Exp(Id(y)))) controlStack);
  (Stack.push (Statement(Exp(AExp(x)))) controlStack);
); 
| Sub(Id(x), Id(y)) ->  
(
  (Stack.push (ExpOc(OPSUB)) controlStack);
  (Stack.push (Statement(Exp(Id(y)))) controlStack);
  (Stack.push (Statement(Exp(Id(x)))) controlStack);
); 
```

Ao ler o #SUB, fazemos um pop na pilha de valores para ler o valor X(N1) e verificamos que é do tipo inteiro. Depois fazemos outro POP para ler o valor Y(N2) e verificamos que este também é do tipo inteiro. Depois subtraimos eles, colocando o resultado na pilha de valores. Caso não sejam, cairíamos em uma Exception.

```
δ(#SUB :: C, Num(N₁) :: Num(N₂) :: V, S) = δ(C, N₁ - N₂ :: V, S)
```

```            
OPSUB -> 
(
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


Quando lê-se um MUL(E1, E2), devemos antes verificar a qual tipo pertencem os dois parâmetros de Expression (Arithmetic Expression ou ID(x)) podendo haver a combinação 2 a 2 deles. Por exemplo, podemos fazer os 4 tipos de multiplicação: 5 * 4; 5 * x; x * 5; x * y;

Para cada um desses casos, agimos da mesma forma: colocamos primeiro o OPTCODE #MUL, depois o E2 (Arithmetic Expression Y) e por fim o E1 (Arithmetic Expression X) na pilha de valores.


```
δ(Mul(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #MUL :: C, V, S) 
```

```            
Mul(AExp(x), AExp(y)) ->
(
  (Stack.push (ExpOc(OPMUL)) controlStack);
  (Stack.push (Statement(Exp(AExp(y)))) controlStack);
  (Stack.push (Statement(Exp(AExp(x)))) controlStack);
);
| Mul(Id(x), AExp(y)) -> 
(
  (Stack.push (ExpOc(OPMUL)) controlStack);
  (Stack.push (Statement(Exp(AExp(y)))) controlStack);
  (Stack.push (Statement(Exp(Id(x)))) controlStack);              
); 
| Mul(AExp(x), Id(y)) ->  
(
  (Stack.push (ExpOc(OPMUL)) controlStack);
  (Stack.push (Statement(Exp(Id(y)))) controlStack);
  (Stack.push (Statement(Exp(AExp(x)))) controlStack);
); 
| Mul(Id(x), Id(y)) ->  
(
  (Stack.push (ExpOc(OPMUL)) controlStack);
  (Stack.push (Statement(Exp(Id(y)))) controlStack);
  (Stack.push (Statement(Exp(Id(x)))) controlStack);                
);
```

Ao ler o #MUL, fazemos um pop na pilha de valores para ler o valor X(N1) e verificamos que é do tipo inteiro. Depois fazemos outro POP para ler o valor Y(N2) e verificamos que este também é do tipo inteiro. Depois multiplicamos eles, colocando o resultado na pilha de valores. Caso não sejam, cairíamos em uma Exception.

```
δ(#MUL :: C, Num(N₁) :: Num(N₂) :: V, S) = δ(C, N₁ * N₂ :: V, S)
```

```
OPMUL -> 
(
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

Quando lê-se um DIV(E1, E2), devemos antes verificar a qual tipo pertencem os dois parâmetros de Expression (Arithmetic Expression ou ID(x)) podendo haver a combinação 2 a 2 deles. Por exemplo, podemos fazer os 4 tipos de divisão: 6 / 2; 6 / x; x / 6; x / y;

Para cada um desses casos, agimos da mesma forma: colocamos primeiro o OPTCODE #DIV, depois o E2 (Arithmetic Expression Y) e por fim o E1 (Arithmetic Expression X) na pilha de valores.


```
δ(Div(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #DIV :: C, V, S)  
```

```              
Div(AExp(x), AExp(y)) -> 
(
  (Stack.push (ExpOc(OPDIV)) controlStack);
  (Stack.push (Statement(Exp(AExp(y)))) controlStack);
  (Stack.push (Statement(Exp(AExp(x)))) controlStack);
);
| Div(Id(x), AExp(y)) -> 
(
  (Stack.push (ExpOc(OPDIV)) controlStack);
  (Stack.push (Statement(Exp(AExp(y)))) controlStack);
  (Stack.push (Statement(Exp(Id(x)))) controlStack);
); 
| Div(AExp(x), Id(y)) ->  
(
  (Stack.push (ExpOc(OPDIV)) controlStack);
  (Stack.push (Statement(Exp(Id(y)))) controlStack);
  (Stack.push (Statement(Exp(AExp(x)))) controlStack);
); 
| Div(Id(x), Id(y)) ->  
(
  (Stack.push (ExpOc(OPDIV)) controlStack);
  (Stack.push (Statement(Exp(Id(y)))) controlStack);
  (Stack.push (Statement(Exp(Id(x)))) controlStack);
); 
```

Ao ler o #DIV, fazemos um pop na pilha de valores para ler o valor X(N1) e verificamos que é do tipo inteiro e diferente de zero, pois não se pode dividir um número por zero. Depois fazemos outro POP para ler o valor Y(N2) e verificamos que este também é do tipo inteiro. Depois dividimos Y por X, colocando o resultado na pilha de valores. Caso não sejam, cairíamos em uma Exception.


```
δ(#DIV :: C, Num(N₁) :: Num(N₂) :: V, S) = δ(C, N₁ / N₂ :: V, S) if N₂ ≠ 0
```

```
OPDIV -> 
(
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

```
δ(Eq(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #EQ :: C, V, S)
```

```
Eq(BExp(x), BExp(y)) -> 
(
  (Stack.push (ExpOc(OPEQ)) controlStack);
  (Stack.push (Statement(Exp(BExp(y)))) controlStack);
  (Stack.push (Statement(Exp(BExp(x)))) controlStack);
);
| Eq(BExp(x), Id(y)) -> 
(
  (Stack.push (ExpOc(OPEQ)) controlStack);
  (Stack.push (Statement(Exp(Id(y)))) controlStack);
  (Stack.push (Statement(Exp(BExp(x)))) controlStack);
);
| Eq(Id(x), BExp(y)) -> 
(
  (Stack.push (ExpOc(OPEQ)) controlStack);
  (Stack.push (Statement(Exp(BExp(y)))) controlStack);
  (Stack.push (Statement(Exp(Id(x)))) controlStack); 
);
| Eq(Id(x), Id(y)) -> 
(
  (Stack.push (ExpOc(OPEQ)) controlStack);
  (Stack.push (Statement(Exp(Id(y)))) controlStack);
  (Stack.push (Statement(Exp(Id(x)))) controlStack);
);
| Eq(AExp(x), AExp(y)) -> 
(
  (Stack.push (ExpOc(OPEQ)) controlStack);
  (Stack.push (Statement(Exp(AExp(y)))) controlStack);
  (Stack.push (Statement(Exp(AExp(x)))) controlStack);
);
| Eq(AExp(x), Id(y)) -> 
(
  (Stack.push (ExpOc(OPEQ)) controlStack);
  (Stack.push (Statement(Exp(Id(y)))) controlStack);
  (Stack.push (Statement(Exp(AExp(x)))) controlStack);
);
| Eq(Id(x), AExp(y)) -> 
(
  (Stack.push (ExpOc(OPEQ)) controlStack);
  (Stack.push (Statement(Exp(AExp(y)))) controlStack);
  (Stack.push (Statement(Exp(Id(x)))) controlStack);
);
```

```
δ(#EQ :: C, Boo(B₁) :: Boo(B₂) :: V, S) = δ(C, B₁ = B₂ :: V, S)
```

```
OPEQ -> 
(
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

```
δ(Lt(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #LT :: C, V, S)
```

```
Lt(AExp(x), AExp(y)) -> 
(
  (Stack.push (ExpOc(OPLT)) controlStack);
  (Stack.push (Statement(Exp(AExp(y)))) controlStack);
  (Stack.push (Statement(Exp(AExp(x)))) controlStack); 
);
| Lt(AExp(x), Id(y)) -> 
(
  (Stack.push (ExpOc(OPLT)) controlStack);
  (Stack.push (Statement(Exp(Id(y)))) controlStack);
  (Stack.push (Statement(Exp(AExp(x)))) controlStack);
);
| Lt(Id(x), AExp(y)) -> 
(
  (Stack.push (ExpOc(OPLT)) controlStack);
  (Stack.push (Statement(Exp(AExp(y)))) controlStack);
  (Stack.push (Statement(Exp(Id(x)))) controlStack);
);
| Lt(Id(x), Id(y)) ->
(
  (Stack.push (ExpOc(OPLT)) controlStack);
  (Stack.push (Statement(Exp(Id(y)))) controlStack);
  (Stack.push (Statement(Exp(Id(x)))) controlStack);
);
```

```
δ(#LT :: C, Num(N₁) :: Num(N₂) :: V, S) = δ(C, N₁ < N₂ :: V, S)
```

```
OPLT -> 
(
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

```
δ(Le(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #LE :: C, V, S)
```

```
Le(AExp(x), AExp(y)) -> 
(
  (Stack.push (ExpOc(OPLE)) controlStack);
  (Stack.push (Statement(Exp(AExp(y)))) controlStack);
  (Stack.push (Statement(Exp(AExp(x)))) controlStack);
);
| Le(AExp(x), Id(y)) -> 
(
  (Stack.push (ExpOc(OPLE)) controlStack);
  (Stack.push (Statement(Exp(Id(y)))) controlStack);
  (Stack.push (Statement(Exp(AExp(x)))) controlStack); 
);
| Le(Id(x), AExp(y)) -> 
(
  (Stack.push (ExpOc(OPLE)) controlStack);
  (Stack.push (Statement(Exp(AExp(y)))) controlStack);
  (Stack.push (Statement(Exp(Id(x)))) controlStack);
);
| Le(Id(x), Id(y)) -> 
(
  (Stack.push (ExpOc(OPLE)) controlStack);
  (Stack.push (Statement(Exp(Id(y)))) controlStack);
  (Stack.push (Statement(Exp(Id(x)))) controlStack);
);
```

```
δ(#LE :: C, Num(N₁) :: Num(N₂) :: V, S) = δ(C, N₁ ≤ N₂ :: V, S)
```

```
OPLE -> 
(
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

```
δ(Gt(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #GT :: C, V, S)
```

```
Gt(AExp(x), AExp(y)) -> 
(
  (Stack.push (ExpOc(OPGT)) controlStack);
  (Stack.push (Statement(Exp(AExp(y)))) controlStack);
  (Stack.push (Statement(Exp(AExp(x)))) controlStack);
);
| Gt(AExp(x), Id(y)) -> 
(
  (Stack.push (ExpOc(OPGT)) controlStack);
  (Stack.push (Statement(Exp(Id(y)))) controlStack);
  (Stack.push (Statement(Exp(AExp(x)))) controlStack);                
);
| Gt(Id(x), AExp(y)) -> 
(
  (Stack.push (ExpOc(OPGT)) controlStack);
  (Stack.push (Statement(Exp(AExp(y)))) controlStack);
  (Stack.push (Statement(Exp(Id(x)))) controlStack);                
);
| Gt(Id(x), Id(y)) -> 
(
  (Stack.push (ExpOc(OPGT)) controlStack);
  (Stack.push (Statement(Exp(Id(y)))) controlStack);
  (Stack.push (Statement(Exp(Id(x)))) controlStack);                
);
```

```
δ(#GT :: C, Num(N₁) :: Num(N₂) :: V, S) = δ(C, N₁ > N₂ :: V, S)
```

```
OPGT -> 
(
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

```
δ(Ge(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #GE :: C, V, S)
```

```
Ge(AExp(x), AExp(y)) -> 
(
  (Stack.push (ExpOc(OPGE)) controlStack);
  (Stack.push (Statement(Exp(AExp(y)))) controlStack);
  (Stack.push (Statement(Exp(AExp(x)))) controlStack);
);
| Ge(AExp(x), Id(y)) -> 
(
  (Stack.push (ExpOc(OPGE)) controlStack);
  (Stack.push (Statement(Exp(Id(y)))) controlStack);
  (Stack.push (Statement(Exp(AExp(x)))) controlStack);                
);
| Ge(Id(x), AExp(y)) -> 
(
  (Stack.push (ExpOc(OPGE)) controlStack);
  (Stack.push (Statement(Exp(AExp(y)))) controlStack);
  (Stack.push (Statement(Exp(Id(x)))) controlStack);                
);
| Ge(Id(x), Id(y)) -> 
(
  (Stack.push (ExpOc(OPGE)) controlStack);
  (Stack.push (Statement(Exp(Id(y)))) controlStack);
  (Stack.push (Statement(Exp(Id(x)))) controlStack);                
);
```

```
δ(#GE :: C, Num(N₁) :: Num(N₂) :: V, S) = δ(C, N₁ ≥ N₂ :: V, S)
```

```
OPGE -> 
(
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

```
δ(And(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #AND :: C, V, S)
```

```
And(BExp(x), BExp(y)) -> 
(
  (Stack.push (ExpOc(OPAND)) controlStack);
  (Stack.push (Statement(Exp(BExp(y)))) controlStack);
  (Stack.push (Statement(Exp(BExp(x)))) controlStack);
);
| And(BExp(x), Id(y)) -> 
(
  (Stack.push (ExpOc(OPAND)) controlStack);
  (Stack.push (Statement(Exp(Id(y)))) controlStack);
  (Stack.push (Statement(Exp(BExp(x)))) controlStack);
);
| And(Id(x), BExp(y)) -> 
(
  (Stack.push (ExpOc(OPAND)) controlStack);
  (Stack.push (Statement(Exp(BExp(y)))) controlStack);
  (Stack.push (Statement(Exp(Id(x)))) controlStack);
);
| And(Id(x), Id(y)) -> 
(
  (Stack.push (ExpOc(OPAND)) controlStack);
  (Stack.push (Statement(Exp(Id(y)))) controlStack);
  (Stack.push (Statement(Exp(Id(x)))) controlStack);
);
```

```
δ(#AND :: C, Boo(B₁) :: Boo(B₂) :: V, S) = δ(C, B₁ ∧ B₂ :: V, S)
```

```
OPAND -> 
(
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

```
δ(Or(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #OR :: C, V, S)
```

```
Or(BExp(x), BExp(y)) -> 
(
  (Stack.push (ExpOc(OPOR)) controlStack);
  (Stack.push (Statement(Exp(BExp(y)))) controlStack);
  (Stack.push (Statement(Exp(BExp(x)))) controlStack);
);
| Or(BExp(x), Id(y)) -> 
(
  (Stack.push (ExpOc(OPOR)) controlStack);
  (Stack.push (Statement(Exp(Id(y)))) controlStack);
  (Stack.push (Statement(Exp(BExp(x)))) controlStack);
);
| Or(Id(x), BExp(y)) -> 
(
  (Stack.push (ExpOc(OPOR)) controlStack);
  (Stack.push (Statement(Exp(BExp(y)))) controlStack);
  (Stack.push (Statement(Exp(Id(x)))) controlStack);
);
| Or(Id(x), Id(y)) -> 
(
  (Stack.push (ExpOc(OPOR)) controlStack);
  (Stack.push (Statement(Exp(Id(y)))) controlStack);
  (Stack.push (Statement(Exp(Id(x)))) controlStack);
);
```

```
δ(#OR :: C, Boo(B₁) :: Boo(B₂) :: V, S) = δ(C, B₁ ∨ B₂ :: V, S)
```

```
OPOR -> 
(
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

```
δ(Not(E) :: C, V, S) = δ(E :: #NOT :: C, V, S)
```

```
Not(BExp(x)) -> 
(
  (Stack.push (ExpOc(OPNOT)) controlStack);
  (Stack.push (Statement(Exp(BExp(x)))) controlStack); 
);
| Not(Id(x)) -> 
(
  (Stack.push (ExpOc(OPNOT)) controlStack);
  (Stack.push (Statement(Exp(Id(x)))) controlStack);
);
```

```
δ(#NOT :: C, Boo(True) :: V, S) = δ(C, False :: V, S)
δ(#NOT :: C, Boo(False) :: V, S) = δ(C, True :: V, S)
```

```
OPNOT -> 
(
  let x = (Stack.pop valueStack) in
    match x with
      | Bool(i) -> (
        (Stack.push (Bool(not(i))) valueStack);
      );
      
      | _ -> raise (AutomatonException "Error on #NOT");
);   
```

```
δ(Id(W) :: C, V, E, S) = δ(C, B :: V, E, S), where E[W] = l ∧ S[l] = B
```

```
Id(id) -> 
(
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

```
δ(Assign(W, X) :: C, V, E, S) = δ(X :: #ASSIGN :: C, W :: V, E, S')
```

```
Assign(Id(x), y) -> 
(
    (Stack.push (CmdOc(OPASSIGN)) controlStack );
    (Stack.push (Statement(Exp(y))) controlStack );
    (Stack.push (Str(x)) valueStack);
);
```

```
δ(#ASSIGN :: C, T :: W :: V, E, S) = δ(C, V, E, S'), where E[W] = l ∧ S' = S/[l ↦ T]
```

```
OPASSIGN -> 
(
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

```
δ(Loop(X, M) :: C, V, E, S) = δ(X :: #LOOP :: C, Loop(X, M) :: V, E, S)
```

```
Loop( BExp(x), y) -> 
(
  (Stack.push (CmdOc(OPLOOP)) controlStack);
  (Stack.push (Statement(Exp(BExp(x)))) controlStack );
  (Stack.push (Control(Statement(Cmd(Loop(BExp(x), y))))) valueStack ); 
);
| Loop(Id(x), y) -> 
(
  (Stack.push (CmdOc(OPLOOP)) controlStack);
  (Stack.push (Statement(Exp(Id(x)))) controlStack );
  (Stack.push (Control(Statement(Cmd(Loop(Id(x), y))))) valueStack );
);
```

```
δ(#LOOP :: C, Boo(true) :: Loop(X, M) :: V, E, S) = δ(M :: Loop(X, M) :: C, V, E, S)
δ(#LOOP :: C, Boo(false) :: Loop(X, M) :: V, E, S) = δ(C, V, E, S)
```

```
OPLOOP -> 
(
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

```
δ(Cond(X, M₁, M₂) :: C, V, E, S) = δ(X :: #COND :: C, Cond(X, M₁, M₂) :: V, E, S)
```

```
Cond(BExp(x), y, z) -> 
(
  (Stack.push (CmdOc(OPCOND)) controlStack);
  (Stack.push (Statement(Exp(BExp(x)))) controlStack );
  (Stack.push (Control(Statement(Cmd(Cond(BExp(x), y, z))))) valueStack );
);
| Cond(Id(x), y, z) -> 
(
  (Stack.push (CmdOc(OPCOND)) controlStack);
  (Stack.push (Statement(Exp(Id(x)))) controlStack );
  (Stack.push (Control(Statement(Cmd(Cond(Id(x), y, z))))) valueStack );
);
```

```
δ(#COND :: C, Boo(true) :: Cond(X, M₁, M₂) :: V, E, S) = δ(M₁ :: C, V, E, S)
δ(#COND :: C, Boo(false) :: Cond(X, M₁, M₂) :: V, E, S) = δ(M₂ :: C, V, E, S)
```

```
OPCOND -> 
(
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

```
δ(CSeq(M₁, M₂) :: C, V, E, S) = δ(M₁ :: M₂ :: C, V, E, S)
```

```
CSeq(x, y) -> 
(
  (Stack.push (Statement(Cmd(y))) controlStack );
  (Stack.push (Statement(Cmd(x))) controlStack );
);
```
