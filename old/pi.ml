

class statement  = object

end;;


(* Expressoes *)
class expression  = object
  inherit statement 
end;;

class arithmeticExpression = object
  inherit expression 
end;;

class num  (value : float) = object
  method getValue = value
end;;

class sum (a: expression) (b: expression) = object
  inherit arithmeticExpression
end;;


let z = new num 4.0 in
  print_float z#getValue

(* type expOptCode = SUM | SUB | MUL | DIV | EQ | LT | LE | GT | GE | AND | OR | NOT *)