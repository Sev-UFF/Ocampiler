(* open Pi;;

let z = new num 5.0 in
  print_float z#getValue;; *)

open Util;;
open Pi;;
open Printf;;

let willReadFile = ref false;;
let fileContents = ref "";;

let willPrintSourceCode = ref false;;

let willPrintTree = ref false;;

let willPrintStats = ref false;;

let willReadSpecificState = ref false;;
let willPrintSpecificState = ref false;;
let displayState = ref (-1);;

let willPrintStackTrace = ref false;;

let willReadSpecificLastState = ref false;;
let willPrintSpecificLastState = ref false;;
let displayLastState =  ref (-1);;
  
    
let () =
  for i = 1 to Array.length Sys.argv - 1 do 
    let arg = Sys.argv.(i) in 
      (* printf "[%i] %s\n" i arg; *)

      if arg = "-f" then begin
        willReadFile := true;
      end else if arg = "--state" then begin
        willReadSpecificState := true;
        willPrintSpecificState := true;
      end else if arg = "--last" then begin
        willReadSpecificLastState := true;
        willPrintSpecificLastState := true;
      end else if arg = "-a" then begin
        willPrintTree := true;
      end else if arg = "-t" then begin 
        willPrintStackTrace := true;
      end else if arg = "-s" then begin 
        willPrintSourceCode := true;
      end else if arg = "--stats" then begin 
        willPrintStats := true;
      end else begin
        if !willReadFile then begin 
          fileContents := readInputFile arg;
          willReadFile := false;
        end else if !willReadSpecificState then begin
          displayState := int_of_string arg;
          willReadSpecificState := false;
        end else if !willReadSpecificLastState then begin
          displayLastState := int_of_string arg;
          willReadSpecificLastState := false;
        end else begin
          printf "%s is not a valid argument\n" arg;
        end
      end
  done;

  if !fileContents = "" then raise (Invalid_argument "Arquivo não inserido.");

  if !(willPrintSpecificState) && !(displayState) == -1 then raise (Invalid_argument "Estado a ser analisado não especificado."); 

  if !(willPrintSpecificLastState) && !(displayLastState) == -1 then raise (Invalid_argument "Estado a ser analisado não especificado."); 

  if !willPrintSourceCode then print_endline ("Código fonte Imπ:\n" ^ !fileContents  ^ "\n");
  
  let tree = Statement(Parser.main Lexer.token (Lexing.from_string !fileContents) )
  and controlStack = (Stack.create()) 
  and valueStack = (Stack.create()) 
  and environment = (Hashtbl.create 10)
  and memory = (Hashtbl.create 10)  in

        if !willPrintTree then print_endline ("Árvore Sintática:\n" ^ (string_of_ctn tree) ^ "\n");

        (Stack.push tree controlStack);
        (*inicialização de y*)
        (Hashtbl.add environment "y" (Automaton.Loc(23)) );
        (Hashtbl.add  memory 23 (Automaton.Integer(19)) );
        (*inicialização de z*)
         (Hashtbl.add environment "z" (Automaton.Loc(1)) );
        (Hashtbl.add memory 1 (Automaton.Integer(77)) );
        (*inicialização de x *)
        (Hashtbl.add environment "x" (Automaton.Loc(24))  );
        (Hashtbl.add memory 24 (Automaton.Integer(13)) );
        (*inicialização de i *)
        (Hashtbl.add environment "i" (Automaton.Loc(456))  );
        (Hashtbl.add memory 456 (Automaton.Integer(0)) );


        let t0 = Unix.gettimeofday () in
        Automaton.delta controlStack valueStack environment memory;
        let t1 = Unix.gettimeofday () in

        let length = List.length !(Automaton.trace) in

        if !willPrintStackTrace then begin
          List.iteri printStackTraceItem !(Automaton.trace);
        end else if !willPrintSpecificLastState then begin
          let state = length - (!displayLastState + 1) in
          printStackTraceItem (state) (List.nth !(Automaton.trace) state);
        end else if !willPrintSpecificState then begin 
          let state = !displayState in
          printStackTraceItem (state) (List.nth !(Automaton.trace) state);
        end;
        
        if !willPrintStats then begin
          print_endline("\nStatus do autômato");
          print_endline("Número de passos: " ^ string_of_int(length) );
          print_endline("Tempo de execução (em segundos): " ^ string_of_float(t1 -. t0));
        end;;

