(* open Pi;;

let z = new num 5.0 in
  print_float z#getValue;; *)

open Util;;
open Pi;;
open Printf;;

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
  and controlStack = (Stack.create()) and valueStack = (Stack.create()) 
  and environment =  Environment.empty and memory = Memory.empty  in
        (Stack.push (Statement(tree)) controlStack);
        (*inicialização de y*)
        let environment = (Environment.add "y" (Automaton.Loc(23)) environment) in 
        let memory = (Memory.add 23 (Automaton.Integer(19)) memory) in
        (*inicialização de z*)
        let environment = (Environment.add "z" (Automaton.Loc(1)) environment) in 
        let memory = (Memory.add 1 (Automaton.Integer(77)) memory) in
        (*inicialização de x direto no argumento*)
        Automaton.evaluatePi controlStack valueStack (Environment.add "x" (Automaton.Loc(24)) environment )  (Memory.add 24 (Automaton.Integer(13)) memory);;