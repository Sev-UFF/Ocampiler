(* Definindo pilha *)

class ['t] stack init = object
  val mutable items : 't list = init

  method pop = 
    match items with
    | hd :: tl -> 
      items <- tl;
      Some hd
    | [] -> None

  method push hd =
    items <- hd :: items
  
end;;

(* Definindo arvore. talvez nao seja necessario *)