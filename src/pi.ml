

class statement (type: piDetonationTypes ) (statement list statements)  = object

end;;

type piDetonationTypes = NUM | SUM

(* Expressoes *)
class expression  = object
  inherit statement 
end;;

class arithmeticExpression = object
  inherit expression 
end;;

class num  (value : float) = object
  inherit arithmeticExpression
  method getValue = value
end;;

class sum (a: expression) (b: expression) = object
  inherit arithmeticExpression
end;;



(* type expOptCode = SUM | SUB | MUL | DIV | EQ | LT | LE | GT | GE | AND | OR | NOT *)

