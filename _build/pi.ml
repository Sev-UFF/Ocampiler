

class statement  = object

end;;


(* Expressoes *)
class expression  = object
  inherit statement 
end;;

class arithmeticExpression init = object
  inherit expression 
end;;

class num  (value : float) init = object
  method getValue = value
end;;



type xpOptCode = SUM | SUB | MUL | DIV | EQ | LT | LE | GT | GE | AND | OR | NOT