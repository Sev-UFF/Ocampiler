(* open Pi;;

let z = new num 5.0 in
  print_float z#getValue;; *)

open Util;;
open Pi;;
open Printf;;
open Dictionary.AssocList;;

let willReadFile = ref false;;
let fileContents = ref "";;
  
    
let () =
  for i = 1 to Array.length Sys.argv - 1 do 
    let arg = Sys.argv.(i) in 
      (* printf "[%i] %s\n" i arg; *)

      if arg = "-f" then begin
        willReadFile := true;
      end else begin
        if !willReadFile then begin 
          fileContents := readInputFile arg;
          willReadFile := false;
        end else begin
          printf "%s is not a valid argument\n" arg;
        end
      end
  done;
  (* reclamar se nao tiver aberto o arquivo *)
  print_endline !fileContents;

  
  let tree = Parser.main Lexer.token (Lexing.from_string !fileContents) 
  and enviroment = make()  in
        Automaton.evaluatePi [Statement(tree)] [] enviroment;; 