open Printf;;

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


let readInputFile file_name =
  let ch = open_in file_name in
    let s = really_input_string ch (in_channel_length ch) in
    close_in ch;
    s